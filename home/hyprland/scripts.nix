{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScript;
  inherit (lib) getExe mkOption types;

  jq = getExe pkgs.jq;
  notify-send = getExe pkgs.libnotify;
in {
  options = {
    modules.hyprland.scripts = mkOption {
      description = "Scripts for Hyprland";
      type = types.attrs;
    };
  };

  config = {
    modules.hyprland.scripts = {
      pin = writeShellScript "pin" ''
        if ! hyprctl -j activewindow | ${jq} -e .floating; then
          hyprctl dispatch togglefloating
        fi
        hyprctl dispatch pin
      '';

      socket = writeShellScript "socket" ''
        ${getExe pkgs.socat} -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
          action="''${event%%>>*}"
          details="''${event##*>>}"

          case "$action" in
            workspace)
              monitor="$(hyprctl -j monitors | ${jq} -r '.[] | select(.focused == true) | .specialWorkspace')"
              if ${jq} -e '.id != 0' <<<"$monitor"; then
                hyprctl dispatch togglespecialworkspace "$(${jq} -r '.name' <<<"$monitor" | cut -d':' -f2)"
              fi
              ;;
          esac
        done
      '';

      openImage = writeShellScript "open-image" ''
        case "$(wl-paste --list-types)" in
          *text*)
            ${notify-send} 'Opening image URL'
            curl -sL "$(wl-paste)" | imv -
            ;;
          *image*)
            ${notify-send} 'Opening image'
            wl-paste | imv -
            ;;
          *)
            ${notify-send} 'Clipboard content is not an image'
            ;;
        esac
      '';

      lockCursor = writeShellScript "lock-cursor" ''
        # This check only works for vertically placed monitors
        if hyprctl -j monitors | ${jq} -e '(.[0].y + .[0].height) > .[1].y'; then
          monitors="$(hyprctl -j monitors)"
          monitor_configs="$(grep -oP '^\s*monitor\s*=\K.*' ~/.config/hypr/hyprland.conf)"
          batch=""
          x=0
          y=0
          while IFS= read -r config; do
            batch="$batch;keyword monitor $(sed -E "s/([^,]*,[^,]*,)[^,]*(,.*)/\1''${x}x$y\2/" <<< "$config")"

            monitor="$(${jq} -r ".[] | select(.name == \"$(grep -o '^[^,]*' <<< "$config")\")" <<< "$monitors")"
            (( x += $(${jq} -r '.width' <<< "$monitor") + 100 ))
            (( y += $(${jq} -r '.height' <<< "$monitor") + 100 ))
          done <<< "$monitor_configs"
          hyprctl --batch "$batch"
        else
          hyprctl reload
        fi
      '';
    };
  };
}
