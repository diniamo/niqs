{ lib, config, pkgs, inputs, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf mkMerge getExe concatStrings mapAttrsToList;
  inherit (pkgs) writeTextFile;
  inherit (pkgs.writers) writeDash writeText;

  cfg = config.custom.dwl;

  # Monitor format: name, mfact, nmaster, scale, layout, rotate/reflect, x, y, resx, resy, rate, mode, adaptive
  configH = ''
    ${cfg.settings}

    static const MonitorRule monrules[] = {
      ${concatStrings (mapAttrsToList (name: monitor: ''
      { "${name}", 0.55f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, ${toString monitor.x}, ${toString monitor.y}, 0, 0, 0.0f, ${toString monitor.mode}, ${if monitor.adaptive then "1" else "0"} },
      '') cfg.monitors)}
    	{ NULL, 0.55f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1, 0, 0, 0.0f, 0, 0 }
    };
  '';
in {
  imports = [ ./settings.nix ];

  options = {
    custom.dwl = {
      enable = mkEnableOption "dwl";

      package = mkPackageOption pkgs "dwl" {};
      finalPackage = mkOption {
        type = types.package;
        readOnly = true;
        description = "The final dwl package.";
      };

      monitors = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            x = mkOption {
              type = types.int;
              description = "The x coordinate.";
            };
            y = mkOption {
              type = types.int;
              description = "The y coordinate.";
            };
            mode = mkOption {
              type = types.int;
              default = 0;
              description = "The index of the mode as reported by wlr-randr.";
            };
            adaptive = mkOption {
              type = types.bool;
              default = false;
              description = "Enable adaptive sync.";
            };
          };
        });
        default = {};
        description = "The monitors to configure.";
      };
      settings = mkOption {
        type = types.lines;
        default = "";
        description = "The config.h contents to use.";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      custom.dwl.finalPackage = (cfg.package.override {
        inherit configH;
      }).overrideAttrs (prev: {
        makeFlags = prev.makeFlags ++ [ "CFLAGS=-O3" ];
        passthru.providedSessions = [ "dwl" ];
      });

      environment.systemPackages = [ cfg.finalPackage ];
      services.displayManager.sessionPackages = [ cfg.finalPackage ];
      systemd.user.targets.dwl-session = {
        description = "dwl compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };
    }

    (import (inputs.nixpkgs + /nixos/modules/programs/wayland/wayland-session.nix) {
      inherit lib pkgs;
      enableWlrPortal = false;
      enableGtkPortal = false;
    })
  ]);
}
