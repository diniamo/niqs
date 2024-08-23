{
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.values) terminal;
in {
  wayland.windowManager.river.settings.spawn = map (command: "'${command}'") ([
      "firefox"
      "gammastep -l 47.1625:19.5033 -t 6500K:2600K"
    ]
    ++ lib.optional (terminal.firstInstance != null) "${terminal.firstInstance}");
}
