{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf escapeShellArgs;
  inherit (lib.types) listOf str attrsOf;
  inherit (lib') toFzfColorFlagValue;

  cfg = config.custom.fzf;

  colorsRendered = toFzfColorFlagValue cfg.colors;
  flagsRendered = escapeShellArgs cfg.flags;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.fzf = {
      enable = mkEnableOption "fzf";
      package = mkPackageOption pkgs "fzf" {};

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
    custom = {
      fzf.flags = mkIf (cfg.colors != {}) [ "--color=${colorsRendered}" ];
      fish.initOnce = "set -Ux FZF_DEFAULT_OPTS \"${flagsRendered}\"";
    };

    user.packages = [ cfg.package ];
  };
}
