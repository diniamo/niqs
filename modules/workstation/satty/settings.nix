{config, ...}: {
  custom.satty = {
    enable = true;

    settings = {
      general = {
        fullscreen = false;
        early-exit = true;
        initial-tool = "brush";
        copy-command = "wl-copy";
        annotation-size-factor = 1;
        save-after-copy = false;
        default-hide-toolbars = false;
        primary-highlighter = "block";
      };

      font = {
        family = config.stylix.fonts.sansSerif.name;
        style = "Regular";
      };
    };
  };
}
