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
      # TODO: Change to indicator once I set a bar up, if I do
      "${getExe' pkgs.gammastep "gammastep"} -l 47.1625:19.5033 -t 6500K:2600K"
      scripts.socket
      # FIX: this is currently broken with hyprland due to https://github.com/hyprwm/Hyprland/commit/10caa03ce5bc2ce8238c494d59405213d32ddead
      # (getExe flakePkgs.no_decorations_when_only.default)
      (getExe flakePkgs.bgar.default)
    ];
  };
}
