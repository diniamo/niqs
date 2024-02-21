{osConfig, ...}: let
  cfg = osConfig.modules.style;
in {
  home = {
    pointerCursor = {
      package = cfg.cursor.package;
      name = cfg.cursor.name;
      size = cfg.cursor.size;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
