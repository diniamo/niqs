{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;

  kdePackage = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["blue"];
  };
  kvantumPackage = pkgs.catppuccin-kvantum.override {
    accent = "Blue";
    variant = "Macchiato";
  };
in {
  options = {
    stylix.icons = {
      package = mkOption {
        description = "Package providing the icons.";
        type = types.package;
      };
      name = mkOption {
        description = "The icons' name within the package.";
        type = types.str;
      };
    };
  };

  config = {
    stylix = {
      icons = {
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "blue";
        };
        name = "Papirus-Dark";
      };
      targets.qt = {
        colors = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Macchiato.conf";
        kdeglobals = "${kdePackage}/share/color-schemes/CatppuccinMacchiatoBlue.colors";
        kvantum = {
          config = "${kvantumPackage}/share/Kvantum/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.kvconfig";
          svg = "${kvantumPackage}/share/Kvantum/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.svg";
        };
      };
    };
  };
}
