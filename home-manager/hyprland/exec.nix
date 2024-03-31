{
  pkgs,
  lib,
  config,
  flakePkgs,
  ...
}: let
  inherit (lib) getExe' getExe;
  inherit (config.programs.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1] firefox"
      "${getExe' pkgs.gammastep "gammastep-indicator"} -l 47.1625:19.5033 -t 6500K:2600K"
      scripts.socket
      (getExe flakePkgs.no_decorations_when_only.default)
      (getExe flakePkgs.bgar.default)
    ];
  };
}
