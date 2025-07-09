{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) nullOr path;
  inherit (lib') iniSection toBtopConf;

  cfg = config.custom.btop;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.btop = {
      enable = mkEnableOption "btop";
      package = mkPackageOption pkgs "btop" {};
      
      settings = mkOption {
        type = iniSection;
        default = {};
        description = "Configuration written to `.config/btop/btop.conf`.";
      };

      theme = mkOption {
        type = nullOr path;
        default = {};
        description = "Theme file.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    custom.btop.settings.color_theme = mkIf (cfg.theme != null) "nix";

    home.files = {
      ".config/btop/btop.conf" = {
        name = "btop.conf";
        text = mkIf (cfg.settings != {}) (toBtopConf cfg.settings);
      };
      ".config/btop/themes/nix.theme" = mkIf (cfg.theme != null) {
        source = cfg.theme;
      };
    };
  };
}
