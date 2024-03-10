{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  scripts = import ./scripts.nix {inherit pkgs getExe;};
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1] firefox"
      "${pkgs.gammastep}/bin/gammastep-indicator -l 47.1625:19.5033 -t 6500K:3000K"
      "${scripts.socket}"
    ];
  };
}
