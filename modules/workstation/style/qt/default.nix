{ lib, config, pkgs, ... }: let
  inherit (lib) mkOption mkIf recursiveUpdate;

  iniFormat = pkgs.formats.ini {};

  cfg = config.custom.style.qt;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.style.qt = {
      shared = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration to add to both `qt5ct.conf` and `qt6ct.conf`.";
      };

      qt5ct = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration to add to `qt5ct.conf`";
      };

      qt6ct = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration to add to `qt6ct.conf`.";
      };
    };
  };

  config = {
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };

    home.files = {
      ".config/qt5ct/qt5ct.conf" = mkIf (cfg.shared != {} || cfg.qt5ct != {}) { source = iniFormat.generate "qt5ct.conf" (recursiveUpdate cfg.shared cfg.qt5ct); };
      ".config/qt6ct/qt6ct.conf" = mkIf (cfg.shared != {} || cfg.qt6ct != {}) { source = iniFormat.generate "qt6ct.conf" (recursiveUpdate cfg.shared cfg.qt6ct); };
    };
  };
}
