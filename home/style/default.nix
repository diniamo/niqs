{osConfig, ...}: {
  imports = [ ./gtk.nix ];

  # HACK: stylix only mirrors internally defined options (and fonts.*.path for some reason)
  config.stylix.icons = osConfig.stylix.icons;
}
