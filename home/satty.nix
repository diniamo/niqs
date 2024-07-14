{
  pkgs,
  config,
  ...
}: let
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
in {
  home.packages = [pkgs.satty];
  xdg.configFile."satty/config.toml".source = pkgs.writers.writeTOML "satty-config.toml" settings;
}
