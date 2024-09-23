{lib, ...}: let
  settings = {
    screencopy = {
      max_fps = 60;
      allow_token_by_default = true;
    };
  };
in {
  xdg.configFile."hypr/xdph.conf".text = lib.hm.generators.toHyprconf {
    attrs = settings;
  };
}
