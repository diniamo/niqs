{lib, lib', pkgs, config, ...}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optionalString mapAttrsToList;
  inherit (lib.types) package listOf str attrsOf;
  inherit (lib') toFzfColorFlagValue;
  inherit (builtins) concatStringsSep;

  cfg = config.custom.fzf;

  colorsRendered = toFzfColorFlagValue cfg.colors;
  optionsRendered = concatStringsSep " " cfg.options;
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

      options = mkOption {
        type = listOf str;
        default = [];
        description = "Default options added to the `FZF_DEFAULT_OPTS` environment.";
      };
      colors = mkOption {
        type = attrsOf str;
        default = {};
        description = "Colors passed to `--color` using {option}`custom.fzf.options`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.fzf = {
      options = mkIf (cfg.colors != {}) [ "--color=${colorsRendered}" ];

      finalPackage =
        if cfg.options != [] then
          cfg.package.overrideAttrs (prev: {
            nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.makeBinaryWrapper ];
            postInstall = ''
              wrapProgram $out/bin/fzf \
                --set FZF_DEFAULT_OPTS '${optionsRendered}'
            '';
          })
        else cfg.package;
    };
  };
}
