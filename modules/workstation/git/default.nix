{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optionalString getExe;
  inherit (lib.types) attrsOf package nullOr lines;
  inherit (lib.generators) toGitINI;
  inherit (lib') iniType;
  inherit (pkgs) symlinkJoin makeBinaryWrapper git;

  cfg = config.custom.git;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.git = {
      enable = mkEnableOption "git";
      package = mkPackageOption pkgs "git" {};

      settings = mkOption {
        type = iniType;
        default = {};
        description = "Configuration written to `.config/git/config`.";
      };
      ignores = mkOption {
        type = nullOr lines;
        default = null;
        description = "Global ignores written to `.config/git/ignore`.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    home.files = {
      ".config/git/config" = mkIf (cfg.settings != {}) {
        name = "git-config";
        text = toGitINI cfg.settings;
      };
      ".config/git/ignore" = mkIf (cfg.ignores != "") {
        name = "git-ignore";
        text = cfg.ignores;
      };
    };
  };
}
