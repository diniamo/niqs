{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) mkOption types optionalString;
  inherit (pkgs.writers) writeDash;
in {
  options = {
    scripts = mkOption {
      description = "Scripts used throughout my home config";
      type = types.attrs;
      default = {
        openImage = writeDash "open-image" ''
          case "$(wl-paste --list-types)" in
            *image*)
              notify-send 'Opening image'
              wl-paste | swayimg -
              ;;
            *text*)
              notify-send 'Opening image URL'
              curl -sL "$(wl-paste)" | swayimg -
              ;;
            *)
              notify-send 'Clipboard content is not an image'
              ;;
          esac
        '';

        notifyInformation = let
          summary = optionalString osConfig.custom.mobile.enable "\"$(cat /sys/class/power_supply/BAT0/capacity)% - $(cat /sys/class/power_supply/BAT0/status)\"";
        in
          writeDash "notify-information" ''
            if [ -f /tmp/information-notification-id ]; then
              notify-send --replace-id "$(cat /tmp/information-notification-id)" --icon time "$(date +%R)" ${summary}
            else
              notify-send --print-id --icon time "$(date +%R)" ${summary} > /tmp/information-notification-id
            fi
          '';

        toggleInhibitSleep = writeDash "toggle-inhibit-sleep" ''
          set -e

          if kill "$(cat /tmp/sleep-inhibitor-pid)"; then
            rm /tmp/sleep-inhibitor-pid

            notify-send --urgency=low --icon=media-playback-start "Sleep uninhibited"
          else
            systemd-inhibit --what=sleep --why=Manual sleep infinity &
            printf '%s' "$!" > /tmp/sleep-inhibitor-pid

            notify-send --urgency=low --icon=media-playback-pause "Sleep inhibited"
          fi
        '';
      };
    };
  };
}
