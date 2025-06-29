{ config, lib, pkgs, flakePkgs, ... }: let
  inherit (lib) getExe getExe';

  inherit (config) custom;
  inherit (custom) style;
  
  scripts = import ./scripts.nix { inherit pkgs flakePkgs lib config; };
  foot = getExe custom.foot.finalPackage;
  librewolf = getExe custom.librewolf.finalPackage;
  grim = getExe pkgs.grim;
  slurp = getExe pkgs.slurp;
  jq = getExe pkgs.jq;
  swaymsg = getExe' config.programs.sway.package "swaymsg";
  wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
  playerctl = getExe pkgs.playerctl;
  wpctl = getExe' pkgs.wireplumber "wpctl";
  systemctl = getExe' config.systemd.package "systemctl";
in {
  custom = {
    style.matugen.templates.sway-colors.input = ./colors;

    sway.settings = ''
      font pango:${style.fonts.regular.name} ${style.fonts.regular.sizeString}
      floating_modifier Mod4
      hide_edge_borders none
      mouse_warping container

      default_border pixel 1
      default_floating_border pixel 1

      workspace_layout default
      workspace_auto_back_and_forth no

      focus_wrapping no
      focus_follows_mouse yes
      focus_on_window_activation focus

      smart_borders on
      for_window [shell="xwayland"] title_format "<i>%title</i>"
      for_window [floating] border pixel 1

      include ${style.matugen.templates.sway-colors.output}

      input "*" {
        accel_profile flat
        scroll_factor 0.8
        scroll_method on_button_down
        tap disabled
        xkb_layout hu
        xkb_options altwin:swap_lalt_lwin
      }

      swaybg_command ${getExe pkgs.swaybg}
      output "*" {
        bg ${style.wallpaper} fill
      }

      seat "*" {
        xcursor_theme ${style.cursor.name} ${style.cursor.sizeString}
      }

      bindsym Mod4+Space exec ${getExe custom.fuzzel.finalPackage}
      bindsym Mod4+Return exec ${foot}
      bindsym Mod4+e exec ${getExe custom.emacs.finalPackage}
      bindsym Mod4+w exec ${librewolf}

      bindsym Mod4+a exec ${scripts.notifyInformation}
      bindsym Mod4+i exec ${scripts.toggleInhibitor}
      bindsym Mod4+x exec ${scripts.logoutMenu}

      bindsym Control+Print exec ${grim} -g "$(${slurp})" - | ${wl-copy}
      bindsym Mod1+Print exec ${grim} -g "$(${swaymsg} -t get_tree | ${jq} -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')"
      bindsym Print exec ${grim} -o "$(${swaymsg} -t get_outputs | ${jq} -r '.[] | select(.focused) | .name')" - | ${wl-copy}
      bindsym Shift+Print exec ${grim} -g "$(${slurp})" - | ${getExe custom.swayimg.package} -
      bindsym Mod4+o exec ${getExe' pkgs.wl-clipboard "wl-paste"} | ${getExe custom.satty.finalPackage} -f -
      bindsym Mod4+c exec ${getExe pkgs.hyprpicker} --autocopy

      bindsym XF86AudioNext exec ${playerctl} next
      bindsym XF86AudioPrev exec ${playerctl} previous
      bindsym XF86AudioPlay exec ${playerctl} play-pause
      bindsym XF86AudioStop exec ${playerctl} position 0
      bindsym XF86AudioLowerVolume exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.05-
      bindsym XF86AudioRaiseVolume exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.05+
      bindsym XF86AudioMute exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle

      bindsym XF86Tools exec ${getExe pkgs.spotify}
      bindsym XF86Calculator exec ${foot} ${getExe pkgs.libqalculate}
      bindsym XF86HomePage exec ${librewolf}

      bindsym Mod4+f fullscreen
      bindsym Mod4+q kill
      bindsym Mod4+p sticky toggle
      bindsym Mod4+s floating toggle

      bindsym Mod4+0 workspace back_and_forth
      bindsym Mod4+1 workspace 1
      bindsym Mod4+2 workspace 2
      bindsym Mod4+3 workspace 3
      bindsym Mod4+4 workspace 4
      bindsym Mod4+5 workspace 5
      bindsym Mod4+6 workspace 6
      bindsym Mod4+7 workspace 7
      bindsym Mod4+8 workspace 8
      bindsym Mod4+9 workspace 9

      bindsym Mod4+Shift+1 move workspace 1
      bindsym Mod4+Shift+2 move workspace 2
      bindsym Mod4+Shift+3 move workspace 3
      bindsym Mod4+Shift+4 move workspace 4
      bindsym Mod4+Shift+5 move workspace 5
      bindsym Mod4+Shift+6 move workspace 6
      bindsym Mod4+Shift+7 move workspace 7
      bindsym Mod4+Shift+8 move workspace 8
      bindsym Mod4+Shift+9 move workspace 9

      bindsym Mod4+d split vertical
      bindsym Mod4+r split horizontal
      bindsym Mod4+t layout tabbed
      bindsym Mod4+Control+d layout splitv
      bindsym Mod4+Control+r layout splith

      bindsym Mod4+h focus left
      bindsym Mod4+j focus down
      bindsym Mod4+k focus up
      bindsym Mod4+l focus right
      bindsym Mod4+u focus parent
      bindsym Mod4+Tab focus next sibling
      bindsym Mod4+Shift+Tab focus prev sibling

      bindsym Mod4+Control+h resize shrink width 50 px
      bindsym Mod4+Control+j resize grow height 50 px
      bindsym Mod4+Control+k resize shrink height 50 px
      bindsym Mod4+Control+l resize grow width 50 px

      bindsym Mod4+Shift+h move left
      bindsym Mod4+Shift+j move down
      bindsym Mod4+Shift+k move up
      bindsym Mod4+Shift+l move right
      bindsym Mod4+Shift+m move window mark mark

      bindsym Mod4+m mark --toggle mark
      bindsym Mod4+Control+m [con_mark="mark"] focus
      bindsym Mod4+Mod1+m swap container with mark mark

      exec ${librewolf}

      exec ${getExe' pkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      exec ${systemctl} --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      exec ${systemctl} --user start sway-session.target
      exec ${swaymsg} --type subscribe '["shutdown"]' && systemctl --user stop sway-session.target
    '';
  };
}
