{
  pkgs,
  config,
  ...
}: {
  stylix.icons = {
    package = pkgs.catppuccin-papirus-folders.override {
      flavor = "macchiato";
      accent = "blue";
    };
    name = "Papirus-Dark";
  };

  environment.systemPackages = [
    config.stylix.icons.package
    pkgs.libsForQt5.breeze-icons
  ];
  
  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];
}
