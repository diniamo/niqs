{
  pkgs,
  lib,
  ...
}: {
  programs.sway = {
    enable = true;
    extraPackages = [];
    extraOptions = ["--unsupported-gpu"];
  };

  xdg.portal = {
    config.sway."org.freedesktop.impl.portal.Screenshot.PickColor" = lib.getExe pkgs.hyprpicker;
    wlr.settings.screencast = {
      max_fps = 60;
    };
  };
}
