{config, ...}: {
  gtk.iconTheme = {
    inherit (config.stylix.icons) package name;
  };
}
