{ pkgs, lib, config }: let
  inherit (lib) optionalString getExe;
  inherit (pkgs) writeDash writeBash;
in {
  notifyInformation = let
    summary = optionalString config.custom.mobile.enable "\"$(cat /sys/class/power_supply/BAT0/capacity)% - $(cat /sys/class/power_supply/BAT0/status)\"";
  in writeDash "notify-information" ''
    if [ -f /tmp/information-notification-id ]; then
      notify-send --replace-id "$(cat /tmp/information-notification-id)" --icon time "$(date +%R)" ${summary}
    else
      notify-send --print-id --icon time "$(date +%R)" ${summary} > /tmp/information-notification-id
    fi
  '';

  toggleInhibitSleep = writeDash "toggle-inhibit-sleep" ''
    if kill "$(cat /tmp/toggle-inhibit-sleep-pid 2>/dev/null)" 2>/dev/null; then
      rm /tmp/toggle-inhibit-sleep-pid
      notify-send --urgency=low --icon=media-playback-start "Sleep uninhibited"
    else
      ${getExe pkgs.daemonize} -p /tmp/toggle-inhibit-sleep-pid ${getExe flakePkgs.niqspkgs.wayhibitor} &
      notify-send --urgency=low --icon=media-playback-pause "Sleep inhibited"
    fi
  '';

  logoutMenu = writeBash "logout-menu" ''
    case "$(echo -en 'Suspend\0icon\x1fsleep\nShutdown\0icon\x1fsystem-shutdown\nReboot\0icon\x1fsystem-reboot\nWindows\0icon\x1fpreferences-system-windows\nLock\0icon\x1fsystem-lock-screen\nLogout\0icon\x1fsystem-log-out' | fuzzel --dmenu)" in
      Suspend) systemctl suspend ;;
      Shutdown) systemctl poweroff ;;
      Reboot) systemctl reboot ;;
      Windows) systemctl reboot --boot-loader-entry=auto-windows ;;
      Lock) loginctl lock-session ;;
      Logout) loginctl terminate-user "$USER" ;;
    esac
  '';
}
