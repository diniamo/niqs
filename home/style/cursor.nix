{osConfig, ...}: let
  cfg = osConfig.modules.style;
in {
  home = {
    pointerCursor = {
      inherit (cfg.cursor) package name size;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
