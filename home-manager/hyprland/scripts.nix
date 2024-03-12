{
  pkgs,
  getExe,
}: let
  inherit (pkgs) writeShellScript;
in {
  pin = writeShellScript "pin" ''
    if ! hyprctl -j activewindow | ${getExe pkgs.jq} -e .floating; then
      hyprctl dispatch togglefloating
    fi
    hyprctl dispatch pin
  '';

  # Usage: <script> <scratchpad name> <commands...>
  scratchpad = writeShellScript "scratchpad" ''
    workspace_name="$1"
    windows="$(hyprctl -j clients | jq ".[] | select(.workspace.name == \"special:$workspace_name\")")"
    if [[ -z "$windows" ]]; then
      shift
      for cmd in "$@"; do
        hyprctl dispatch exec "[workspace special:$workspace_name] $cmd"
      done
    else
      hyprctl dispatch togglespecialworkspace "$workspace_name"
    fi
  '';

  socket = writeShellScript "socket" ''
    ${getExe pkgs.socat} -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
      action="''${event%%>>*}"
      details="''${event##*>>}"

      case "$action" in
        workspace)
          if hyprctl -j monitors | ${getExe pkgs.jq} -e '.[] | select(.focused == true) | .specialWorkspace.id != 0'; then
            hyprctl dispatch togglespecialworkspace
          fi
          ;;
      esac
    done
  '';

  openImage = writeShellScript "open-image" ''
    case "$(wl-paste --list-types)" in
      *text*)
        notify-send 'Opening image URL'
        curl -sL "$(wl-paste)" | imv -
        ;;
      *image*)
        notify-send 'Opening image'
        wl-paste | imv -
        ;;
      *)
        notify-send 'Failed to open image'
        ;;
    esac
  '';
}
