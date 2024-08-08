{osConfig, ...}: {
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  config = {
    # HACK: stylix only mirrors internally defined options (and fonts.*.path for some reason)
    stylix = {
      inherit (osConfig.stylix) icons;
      targets.qt = osConfig.stylix.targets.qt;
    };
  };
}
