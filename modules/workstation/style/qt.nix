{pkgs, ...}: let
  kdePackage = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["blue"];
  };

  kvantumPackage = pkgs.catppuccin-kvantum.override {
    accent = "blue";
    variant = "macchiato";
  };
in {
  # This is required, because the hm module is missing something
  # I may or may not be too lazy to fix it
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  stylix.targets.qt = {
    colors = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Macchiato.conf";
    kdeglobals = "${kdePackage}/share/color-schemes/CatppuccinMacchiatoBlue.colors";
    kvantum = {
      config = "${kvantumPackage}/share/Kvantum/catppuccin-macchiato-blue/catppuccin-macchiato-blue.kvconfig";
      svg = "${kvantumPackage}/share/Kvantum/catppuccin-macchiato-blue/catppuccin-macchiato-blue.svg";
    };
  };
}
