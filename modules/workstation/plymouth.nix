{config, ...}: {
  stylix.targets.plymouth.logoAnimated = false;

  boot.plymouth = {
    enable = true;
    font = config.stylix.fonts.sansSerif.path;
  };
}
