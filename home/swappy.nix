{
  pkgs,
  lib,
  config,
  ...
}: let
  conf = {
    save_dir = config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR;
    show_panel = true;
    text_font = config.stylix.fonts.sansSerif.name;
  };
in {
  home.packages = [pkgs.swappy];
  # The format is actually GLib conf, but ini works
  xdg.configFile."swappy/config".text = lib.generators.toINI {} {Default = conf;};
}
