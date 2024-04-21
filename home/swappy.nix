{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  conf = {
    save_dir = config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR;
    show_panel = true;
    text_font = osConfig.modules.style.font.name;
  };
in {
  home.packages = [pkgs.swappy];
  # The format is actually GLib conf, but ini works
  xdg.configFile."swappy/config".text = lib.generators.toINI {} {Default = conf;};
}
