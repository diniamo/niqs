{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.modules.style.qt;
in {
  options.modules.style.qt = {
    theme = {
      package = mkOption {
        type = types.package;
        description = "The package for the QT theme";
        default = pkgs.catppuccin-qt5ct;
      };
      colorScheme = mkOption {
        type = types.path;
        description = "The source file for kdeglobals";
        default = "${cfg.theme.package}/share/qt5ct/colors/Catppuccin-Macchiato.conf";
      };
    };

    kdeglobals = mkOption {
      type = types.path;
      description = "Path to the kdeglobals file";
      default = let
        package = pkgs.catppuccin-kde.override {
          flavour = ["macchiato"];
          accents = ["blue"];
        };
      in "${package}/share/color-schemes/CatppuccinMacchiatoBlue.colors";
    };

    kvantum = {
      package = mkOption {
        type = types.package;
        description = "The package for the kvantum theme";
        default = pkgs.catppuccin-kvantum.override {
          accent = "Blue";
          variant = "Macchiato";
        };
      };
      config = mkOption {
        type = types.path;
        description = "The path to the .kvconfig file";
        default = "${cfg.kvantum.package}/share/Kvantum/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.kvconfig";
      };
      svg = mkOption {
        type = types.path;
        description = "The path to the .svg file";
        default = "${cfg.kvantum.package}/share/Kvantum/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.svg";
      };
    };
  };

  config.qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
}
