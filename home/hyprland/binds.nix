{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  inherit (osConfig.values) terminal;

  inherit (config) scripts;
  hyprlandScripts = config.programs.hyprland.scripts;

  mod = "SUPER";
  ctrl = "CONTROL";
  alt = "ALT";
  shift = "SHIFT";
  secondary = ctrl;
in {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "${mod}, Return, exec, ${terminal.command}"
      "${mod}${secondary}, Return, exec, ${terminal.command} -- yazi"
      "${mod}, n, exec, neovide"
      "${mod}${secondary}, n, exec, neovide /etc/nixos"
      "${mod}, w, exec, firefox"
      "${mod}, q, killactive"
      "${mod}${secondary}, q, exec, kill -9 $(hyprctl -j activewindow | jaq -r '.pid')"

      "${mod}, Space, exec, fuzzel"
      "${mod}, x, exec, wlogout --show-binds --column-spacing 5 --row-spacing 5"
      # TODO: cliphist

      "${mod}, d, togglespecialworkspace, terminal"
      "${mod}, m, togglespecialworkspace, mixer_tui"
      "${mod}${secondary}, m, togglespecialworkspace, mixer_gui"
      "${mod}, g, togglespecialworkspace, music_gui"
      "${mod}${secondary}, g, togglespecialworkspace, music_tui"
      "${mod}, c, togglespecialworkspace, calculator_tui"
      "${mod}${secondary}, c, togglespecialworkspace, calculator_gui"
      "${mod}, e, togglespecialworkspace, file_manager_tui"
      "${mod}${secondary}, e, togglespecialworkspace, file_manager_gui"

      ", XF86Explorer, exec, sleep 1 && hyprctl dispatch dpms off"
      ", XF86HomePage, exec, firefox"

      ", Print, exec, grimblast --notify copy output"
      "${ctrl}, Print, exec, grimblast --notify --freeze copy area"
      "${shift}, Print, exec, grimblast --freeze save area - | swayimg -"
      "${alt}, Print, exec, grimblast --notify copy active"

      "${mod}, s, exec, wl-paste | satty -f -"

      # TODO: hyprpicker

      # "${mod}, iacute, exec, ${playerctl} previous"
      # "${mod}, y, exec, ${playerctl} next"
      # "${mod}, p, exec, ${playerctl} play-pause"
      # "${mod}, r, exec, ${playerctl} position 0"

      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
      # The stop function is pretty much useless, use it to restart the playing media instead
      ", XF86AudioStop, exec, playerctl position 0"
      ", XF86AudioPlay, exec, playerctl play-pause"

      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      ''${mod}${secondary}, v, exec, notify-send "Playing video" "$(wl-paste)"; mpv "$(wl-paste | sed 's/&.*$//')"''
      ''${mod}, i, exec, ${scripts.openImage}''
      ''${mod}${secondary}, w, exec, notify-send "Opening link" "$(wl-paste)"; firefox "$(wl-paste)"''

      "${mod}, h, movefocus, l"
      "${mod}, j, movefocus, d"
      "${mod}, k, movefocus, u"
      "${mod}, l, movefocus, r"

      "${mod}${shift}, h, movewindow, l"
      "${mod}${shift}, j, movewindow, d"
      "${mod}${shift}, k, movewindow, u"
      "${mod}${shift}, l, movewindow, r"

      "${mod}${shift}, Space, movetoworkspace, +0"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, 0, workspace, 10"

      "${mod}, Tab, workspace, previous"

      "${mod}${shift}, 1, movetoworkspacesilent, 1"
      "${mod}${shift}, 2, movetoworkspacesilent, 2"
      "${mod}${shift}, 3, movetoworkspacesilent, 3"
      "${mod}${shift}, 4, movetoworkspacesilent, 4"
      "${mod}${shift}, 5, movetoworkspacesilent, 5"
      "${mod}${shift}, 6, movetoworkspacesilent, 6"
      "${mod}${shift}, 7, movetoworkspacesilent, 7"
      "${mod}${shift}, 8, movetoworkspacesilent, 8"
      "${mod}${shift}, 9, movetoworkspacesilent, 9"
      "${mod}${shift}, 0, movetoworkspacesilent, 10"

      "${mod}${shift}${secondary}, 1, movetoworkspace, 1"
      "${mod}${shift}${secondary}, 2, movetoworkspace, 2"
      "${mod}${shift}${secondary}, 3, movetoworkspace, 3"
      "${mod}${shift}${secondary}, 4, movetoworkspace, 4"
      "${mod}${shift}${secondary}, 5, movetoworkspace, 5"
      "${mod}${shift}${secondary}, 6, movetoworkspace, 6"
      "${mod}${shift}${secondary}, 7, movetoworkspace, 7"
      "${mod}${shift}${secondary}, 8, movetoworkspace, 8"
      "${mod}${shift}${secondary}, 9, movetoworkspace, 9"
      "${mod}${shift}${secondary}, 0, movetoworkspace, 10"

      "${mod}, t, togglefloating"
      "${mod}, p, exec, ${hyprlandScripts.pin}"
      ", F11, fullscreen, 0"
      "${mod}, f, fullscreen, 1"
      "${mod}, z, exec, ${hyprlandScripts.lockCursor}"

      "${mod}${secondary}, x, exec, ${getExe pkgs.zenity} --question --text 'Do you really want to reboot to Windows?' --icon system-reboot && systemctl reboot --boot-loader-entry=auto-windows"
    ];
    binde = [
      "${mod}${ctrl}, h, resizeactive, -50 0"
      "${mod}${ctrl}, j, resizeactive, 0 50"
      "${mod}${ctrl}, k, resizeactive, 0 -50"
      "${mod}${ctrl}, l, resizeactive, 50 0"

      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      ", XF86MonBrightnessUp, exec, brightnessctl set 2%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 2%- -n"
    ];
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
