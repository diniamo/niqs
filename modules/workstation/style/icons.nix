{pkgs, ...}: {
  stylix.icons = {
    package = pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "blue";
    };
    name = "Papirus-Dark";
  };
}
