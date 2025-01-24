{
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (config.wayland.windowManager.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once =
      [
        "[workspace 1] firefox"
        scripts.socket
      ]
      ++ lib.optional (osConfig.values.terminal.firstInstance != null) "[workspace special:terminal silent] ${osConfig.values.terminal.firstInstance}";
  };
}
