{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScript;
  inherit (lib) getExe mkOption types;

  jq = getExe pkgs.jq;
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
            ${getExe pkgs.libnotify} 'Opening image URL'
            curl -sL "$(wl-paste)" | imv -
            ;;
          *image*)
            ${getExe pkgs.libnotify} 'Opening image'
            wl-paste | imv -
            ;;
          *)
            ${getExe pkgs.libnotify} 'Clipboard content is not an image'
            ;;
        esac
      '';
    };
  };
}
