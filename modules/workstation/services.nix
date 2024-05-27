{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe mkOption types;

  xdgPortalName = config.xdg.portal.name;
in {
  options = {
    xdg.portal.name = mkOption {
      description = "The name of the xdg desktop portal, used both in the package name and to specify the default portal";
      type = types.enum ["wlr" "gtk" "xapp" "gnome" "cosmic" "hyprland" "kde" "lxqt" "pantheon"];
      default = "kde";
    };
  };

  config = {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs."xdg-desktop-portal-${xdgPortalName}"];
      config.common.default = ["hyprland" xdgPortalName];
    };

    services = {
      greetd = {
        enable = true;
        restart = true;
        settings = {
          default_session = {
            command = "${getExe pkgs.greetd.tuigreet} --window-padding 1 --time --time-format '%R - %F' --remember --remember-session --asterisks";
            user = "greeter";
          };
        };
      };
      pipewire = {
        enable = true;
        wireplumber.enable = true;
        pulse.enable = true;
        alsa.enable = true;
        jack.enable = true;
      };
      power-profiles-daemon.enable = true;
      blueman.enable = true;

      ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider =
          if config.programs.gamemode.enable
          then
            pkgs.ananicy-rules-cachyos.overrideAttrs {
              preInstall = ''
                rm -r 00-default/games
              '';
            }
          else pkgs.ananicy-cpp-rules;
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}
