{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScript;
  inherit (pkgs.writers) writeDash;
  inherit (lib) getExe mkOption types;
in {
  options = {
    modules.hyprland.scripts = mkOption {
      description = "Scripts for Hyprland";
      type = types.attrs;
    };
  };

  config = {
    modules.hyprland.scripts = {
      pin = writeDash "pin" ''
        if ! hyprctl -j activewindow | jaq -e .floating; then
          hyprctl --batch 'dispatch togglefloating;dispatch pin'
        else
          hyprctl dispatch pin
        fi
      '';

      socket = writeDash "socket" ''
        ${getExe pkgs.socat} -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
          action="''${event%%>>*}"
          details="''${event##*>>}"

          case "$action" in
            workspace)
              monitor="$(hyprctl -j monitors | jaq -r '.[] | select(.focused == true) | .specialWorkspace')"
              if jaq -e '.id != 0' <<<"$monitor"; then
                hyprctl dispatch togglespecialworkspace "$(jaq -r '.name' <<<"$monitor" | cut -d':' -f2)"
              fi
              ;;
          esac
        done
      '';

      lockCursor = writeShellScript "lock-cursor" ''
        # This check only works for vertically placed monitors
        if hyprctl -j monitors | jaq -e '(.[0].y + .[0].height) > .[1].y'; then
          monitors="$(hyprctl -j monitors)"
          monitor_configs="$(grep -oP '^\s*monitor\s*=\K.*' $XDG_CONFIG_HOME/hypr/hyprland.conf)"
          batch=""
          x=0
          y=0
          while IFS= read -r config; do
            batch="$batch;keyword monitor $(sed -E "s/([^,]*,[^,]*,)[^,]*(,.*)/\1''${x}x$y\2/" <<< "$config")"

            monitor="$(jaq -r ".[] | select(.name == \"$(grep -o '^[^,]*' <<< "$config")\")" <<< "$monitors")"
            (( x += $(jaq -r '.width' <<< "$monitor") + 100 ))
            (( y += $(jaq -r '.height' <<< "$monitor") + 100 ))
          done <<< "$monitor_configs"
          hyprctl --batch "$batch"
        else
          hyprctl reload
        fi
      '';
    };
  };
}
