{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optionalString getExe;
  inherit (lib.types) attrsOf package;
  inherit (pkgs) symlinkJoin makeBinaryWrapper git;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.jujutsu;

  settingsFile = tomlFormat.generate "jj-config.toml" cfg.settings;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.jujutsu = {
      enable = mkEnableOption "jujutsu";
      package = mkPackageOption pkgs "jujutsu" {};
      
      settings = mkOption {
        type = attrsOf tomlType;
        default = {};
        description = "Configuration written to `.config/jj/config.toml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    home.files.".config/jj/config.toml" = mkIf (cfg.settings != {}) {
      source = settingsFile;
    };
  };
}
