{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package listOf str attrsOf;
  inherit (lib') toFzfColorFlagValue;
  inherit (pkgs) makeBinaryWrapper;
  inherit (builtins) concatStringsSep;

  cfg = config.custom.fzf;

  colorsRendered = toFzfColorFlagValue cfg.colors;
  flagsRendered = concatStringsSep " " cfg.flags;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.fzf = {
      enable = mkEnableOption "fzf";
      
      package = mkPackageOption pkgs "fzf" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped fzf package.";
      };

      flags = mkOption {
        type = listOf str;
        default = [];
        description = "Default flags added to the `FZF_DEFAULT_OPTS` environment.";
      };
      colors = mkOption {
        type = attrsOf str;
        default = {};
        description = "Colors passed to `--color` using {option}`custom.fzf.flags`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.fzf = {
      flags = mkIf (cfg.colors != {}) [ "--color=${colorsRendered}" ];

      finalPackage =
        if cfg.flags != [] then
          cfg.package.overrideAttrs (prev: {
            nativeBuildInputs = prev.nativeBuildInputs ++ [ makeBinaryWrapper ];
            
            postPatch = "";
            postInstall = ''
              installManPage man/man1/fzf.1 man/man1/fzf-tmux.1

              wrapProgram $out/bin/fzf \
                --set FZF_DEFAULT_OPTS '${flagsRendered}'
            '';
          })
        else cfg.package;
    };
    
    user.packages = [ cfg.finalPackage ];
  };
}
