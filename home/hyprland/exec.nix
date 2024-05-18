{
  pkgs,
  lib,
  config,
  flakePkgs,
  ...
}: let
  inherit (lib) getExe' getExe;
  inherit (config.modules.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1] firefox"
      # TODO: Change to indicator once I set a bar up, if I do
      "${getExe' pkgs.gammastep "gammastep"} -l 47.1625:19.5033 -t 6500K:2600K"
      scripts.socket
      (getExe flakePkgs.bgar.default)
    ];
  };
}
