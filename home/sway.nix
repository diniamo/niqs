{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe;

  inherit (config) scripts;
in {
  home.packages = with pkgs; [
    swaybg
    slurp
    grim
    hyprpicker
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      input."*" = {
        # Worth noting that I also use caps2esc
        xkb_layout = "hu";
        xkb_options = "altwin:swap_lalt_lwin";

        accel_profile = "flat";
        scroll_method = "on_button_down";

        scroll_factor = "0.8";
        tap = "disabled";
      };

      floating = {
        modifier = "Mod4";
        border = 1;
      };
      window = {
        border = 1;
        commands = [
          {
            criteria.shell = "xwayland";
            command = "title_format \"<i>%title</i>\"";
          }
        ];
      };
      focus = {
        mouseWarping = "container";
        newWindow = "focus";
      };
      gaps.smartBorders = "on";
      startup = [{command = "firefox";}];
      # Merging the attributes would not override the default I think?
      modes = {};

      keybindings = {
        "Mod4+Return" = "exec foot";
        "Mod4+n" = "exec neovide";
        "Mod4+Control+n" = "exec neovide /etc/nixos";
        "Mod4+w" = "exec firefox";
        "Mod4+Space" = "exec fuzzel";

        # TODO: Write my own logout menu, why is there no non-gtk one?
        "Mod4+Control+x" = "exec ${getExe pkgs.zenity} --question --text 'Do you really want to reboot to Windows?' --icon system-reboot && systemctl reboot --boot-loader-entry=auto-windows";

        "Mod4+a" = "exec ${scripts.notifyInformation}";
        "Mod4+i" = "exec ${scripts.toggleInhibitSleep}";
        "Mod4+c" = "exec hyprpicker --autocopy";

        "Print" = "exec grim -o \"$(swaymsg -t get_outputs | jaq -r '.[] | select(.focused) | .name')\" - | wl-copy";
        "Control+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Shift+Print" = "exec grim -g \"$(slurp)\" - | swayimg -";
        "Mod1+Print" = ''exec grim -g "$(swaymsg -t get_tree | jaq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')"'';
        "Mod4+s" = "exec wl-paste | satty -f -";

        # TODO: Turn outputs off
        # https://github.com/swaywm/sway/issues/2910
        # "XF86Explorer" = "exec ";
        "XF86HomePage" = "exec firefox";
        "XF86Calculator" = "exec foot qalc";
        "XF86Tools" = "exec spotify";

        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioStop" = "exec playerctl position 0";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";

        "XF86MonBrightnessUp" = "exec brightnessctl set 2%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 2%- -n";

        "Mod4+q" = "kill";
        "Mod4+f" = "fullscreen";
        "Mod4+o" = "floating toggle";
        "Mod4+p" = "sticky toggle";

        "Mod4+d" = "split vertical";
        "Mod4+r" = "split horizontal";
        "Mod4+Control+d" = "layout splitv";
        "Mod4+Control+r" = "layout splith";
        "Mod4+t" = "layout tabbed";

        # TODO: I want tab to wrap
        # and I want the directional binds to focus frames (meaning they shouldn't cycle tabs)
        "Mod4+Tab" = "focus next";
        "Mod4+Shift+Tab" = "focus prev";
        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";

        "Mod4+Control+h" = "resize shrink width 50 px";
        "Mod4+Control+j" = "resize grow height 50 px";
        "Mod4+Control+k" = "resize shrink height 50 px";
        "Mod4+Control+l" = "resize grow width 50 px";

        "Mod4+0" = "workspace back_and_forth";
        "Mod4+1" = "workspace 1";
        "Mod4+2" = "workspace 2";
        "Mod4+3" = "workspace 3";
        "Mod4+4" = "workspace 4";
        "Mod4+5" = "workspace 5";
        "Mod4+6" = "workspace 6";
        "Mod4+7" = "workspace 7";
        "Mod4+8" = "workspace 8";
        "Mod4+9" = "workspace 9";

        "Mod4+Shift+1" = "move workspace 1";
        "Mod4+Shift+2" = "move workspace 2";
        "Mod4+Shift+3" = "move workspace 3";
        "Mod4+Shift+4" = "move workspace 4";
        "Mod4+Shift+5" = "move workspace 5";
        "Mod4+Shift+6" = "move workspace 6";
        "Mod4+Shift+7" = "move workspace 7";
        "Mod4+Shift+8" = "move workspace 8";
        "Mod4+Shift+9" = "move workspace 9";
      };
    };
  };
}
