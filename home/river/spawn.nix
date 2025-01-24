{
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.values) terminal;
in {
  wayland.windowManager.river.settings.spawn = map (command: "'${command}'") ([
      "firefox"
    ]
    ++ lib.optional (terminal.firstInstance != null) terminal.firstInstance);
}
