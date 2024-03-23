{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe';
  inherit (config.programs.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1] firefox"
      "${getExe' pkgs.gammastep "gammastep-indicator"} -l 47.1625:19.5033 -t 6500K:2600K"
      "${scripts.socket}"
    ];
  };
}
