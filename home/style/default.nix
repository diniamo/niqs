{pkgs, ...}: let
  kdePackage = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["blue"];
  };
  kvantumPackage = pkgs.catppuccin-kvantum.override {
    accent = "Blue";
    variant = "Macchiato";
  };
in {
  imports = [
    ./icons.nix
    ./gtk.nix
    ./qt.nix
  ];

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
