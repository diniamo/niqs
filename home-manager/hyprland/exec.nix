{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace 1] firefox"
      "${pkgs.gammastep}/bin/gammastep-indicator -l 47.1625:19.5033 -t 6500K:3000K"
    ];
  };
}
