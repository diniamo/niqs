{
  lib,
  lib',
  osConfig,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge range getExe;
  inherit (lib') shiftLeft;

  inherit (osConfig.values) terminal;
  inherit (config) scripts;

  rest.normal = {
    "Super Return" = "spawn '${terminal.command}'";
    "Super+Control Return" = "spawn '${terminal.command} ${terminal.separator} yazi'";
    "Super n" = "spawn neovide";
    "Super+Control n" = "spawn 'cd /etc/nixos && neovide'";
    "Super w" = "firefox";
    "Super q" = "close";
    # TODO: force kill

    "Super Space" = "spawn fuzzel";
    "Super x" = "spawn 'wlogout --show-binds --column-spacing 5 --row-spacing 5'";
    "Super+Control x" = "spawn '${getExe pkgs.zenity} --question --text \"Do you really want to reboot to the boot menu?\" --icon system-reboot && systemctl reboot --boot-loader-menu=2147483647'";
    # TODO: cliphist

    # TODO: scratchpads

    # TODO: turn off monitors

    "None Print" = "spawn 'wayshot --stdout | wl-copy'";
    "Control Print" = "spawn 'wayshot --slurp $(slurp) --stdout | wl-copy'";
    "Shift Print" = "spawn 'wayshot --slurp $(slurp) --stdout | swayimg -'";
    # TODO: screenshot focused window
    "Super Print" = "spawn 'wayshot --slurp $(slurp) --stdout | satty -f -'";

    # TODO: color picker?

    "Super s" = "spawn 'wl-paste | satty -f -'";
    "Super+Control m" = "spawn 'mpv \"$(wl-paste | sed \"s/&.*$//\")\"'";
    "Super+Control i" = "spawn '${scripts.openImage}'";
    "Super+Control w" = "spawn 'firefox \"$(wl-paste)\"'";

    "Super Comma" = "focus-output previous";
    "Super Period" = "focus-output next";

    "Super+Shift Comma" = "send-to-output previous";
    "Super+Shift Period" = "send-to-output next";

    "Super h" = "focus-view left";
    "Super j" = "focus-view down";
    "Super k" = "focus-view up";
    "Super l" = "focus-view right";

    "Super+Shift h" = "swap left";
    "Super+Shift j" = "swap down";
    "Super+Shift k" = "swap up";
    "Super+Shift l" = "swap right";

    "Super Tab" = "focus-previous-tags";

    "Super+Control h" = "send-layout-cmd rivertile 'main-ratio -0.05'";
    "Super+Control l" = "send-layout-cmd rivertile 'main-ratio +0.05'";

    "Super+Control j" = "send-layout-cmd rivertile 'main-count -1'";
    "Super+Control k" = "send-layout-cmd rivertile 'main-count +1'";

    "Super t" = "toggle-float";
    # TODO: pin
    "Super f" = "toggle-fullscreen"; # TODO: maximize
    "None F11" = "toggle-fullscreen";
    # TODO: lock cursor script
  };

  mouse.normal = {
    "Super BTN_LEFT" = "move-view";
    "Super BTN_RIGHT" = "resize-view";
    "Super BTN_MIDDLE" = "close";
  };

  media = let
    basic = {
      # XF86Explorer = "";
      # ? XF86Browser = "";
      # XF86Calculator = "";
      # XF86Music = "";

      "None XF86AudioPrev" = "spawn 'playerctl previous'";
      "None XF86AudioNext" = "spawn 'playerctl next'";
      "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
      "None XF86AudioStop" = "spawn 'playerctl position 0'";

      "None XF86AudioMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
    };

    repeat = {
      "None XF86AudioRaiseVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'";
      "None XF86AudioLowerVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";

      "None XF86MonBrightnessUp" = "spawn 'brightnessctl set 2%+'";
      "None XF86MonBrightnessDown" = "spawn 'brightnessctl set 2%- -n'";
    };
  in {
    normal = basic;
    "-repeat".normal = repeat;

    locked = basic;
    "-repeat".locked = repeat;
  };

  tags = map (i: let
    index = toString i;
    tag = toString (shiftLeft 1 (i - 1));
  in {
    normal = {
      "Super ${index}" = "set-focused-tags ${tag}";
      "Super+Control ${index}" = "toggle-focused-tags ${tag}";
      "Super+Shift ${index}" = "set-view-tags ${tag}";
      "Super+Shift+Control ${index}" = "toggle-view-tags ${tag}";
    };
  }) (range 1 9);

  maps = [rest media] ++ tags;
in {
  wayland.windowManager.river.settings = {
    map = mkMerge maps;
    map-pointer = mouse;
  };
}
