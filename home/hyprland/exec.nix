{
  lib,
  config,
  flakePkgs,
  osConfig,
  ...
}: let
  inherit (config.programs.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once =
      [
        "[workspace 1] firefox"
        "gammastep -l 47.1625:19.5033 -t 6500K:2600K"
        scripts.socket
        (lib.getExe flakePkgs.bgar.default)
      ]
      ++ lib.optional (osConfig.values.terminal.firstInstance != null) "[workspace special:terminal silent] ${osConfig.values.terminal.firstInstance}";
  };
}
