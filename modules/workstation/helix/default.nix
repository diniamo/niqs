{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf getExe;
  inherit (lib.types) nullOr path;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;

  cfg = config.custom.helix;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.helix = {
      enable = mkEnableOption "helix";
      package = mkPackageOption pkgs "helix" {};

      defaultEditor = mkEnableOption "helix as `$EDITOR`";

      settings = mkOption {
        type = tomlType;
        default = {};
        description = "Configuration written to `.config/helix/config.toml`.";
      };
      theme = mkOption {
        type = nullOr path;
        default = [];
        description = "Theme to use.";
      };
      languageSettings = mkOption {
        type = tomlType;
        default = {};
        description = "Configuration written to `.config/helix/languages.toml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    custom.helix.settings.theme = mkIf (cfg.theme != null) "nix";
    home.files = {
      ".config/helix/config.toml" = mkIf (cfg.settings != {}) { source = tomlFormat.generate "helix-config.toml" cfg.settings; };
      ".config/helix/themes/nix.toml" = mkIf (cfg.theme != null) { source = cfg.theme; };
      ".config/helix/languages.toml" = mkIf (cfg.languageSettings != {}) { source = tomlFormat.generate "helix-languages.toml" cfg.languageSettings; };
    };

    environment.sessionVariables.EDITOR = getExe cfg.package;
  };
}
