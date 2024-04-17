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
        default = pkgs.catppuccin-kde.override {
          flavour = ["macchiato"];
          accents = ["blue"];
          winDecStyles = ["modern"];
        };
      };
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

    kdeglobals = mkOption {
      type = types.path;
      description = "The source file for kdeglobals";
      default = "${cfg.theme.package}/share/color-schemes/CatppuccinMacchiatoBlue.colors";
    };
  };
}
