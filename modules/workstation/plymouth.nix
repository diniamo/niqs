{config, ...}: {
  boot.plymouth = {
    enable = true;
    font = config.stylix.fonts.sansSerif.path;
  };
}
