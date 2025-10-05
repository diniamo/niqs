{ pkgs, lib, config, ... }: let
  inherit (lib) optionalString getExe getExe';
  inherit (pkgs) coreutils;
  inherit (pkgs.writers) writeDash writeBash;

  inherit (config) custom;

  notify-send = getExe pkgs.libnotify;
  cat = getExe' coreutils "cat";
  date = getExe' coreutils "date";
  systemctl = getExe' pkgs.systemd "systemctl";
  loginctl = getExe' pkgs.systemd "loginctl";
in {
  notifyInformation = let
    summary = optionalString custom.mobile.enable "\"$(${cat} /sys/class/power_supply/BAT0/capacity)% - $(${cat} /sys/class/power_supply/BAT0/status)\"";
    common = "--expire-time 2000 --icon time --print-id \"$(${date} +%R)\" ${summary} > /tmp/information-notification-id";
  in writeDash "notify-information.sh" ''
    if [ -f /tmp/information-notification-id ]; then
      ${notify-send} --replace-id "$(${cat} /tmp/information-notification-id)" ${common}
    else
      ${notify-send} ${common}
    fi
  '';

  toggleInhibitor = writeDash "toggle-inhibitor.sh" ''
    if kill "$(${cat} /tmp/manual-inhibitor-pid 2>/dev/null)" 2>/dev/null; then
      rm /tmp/manual-inhibitor-pid
      ${notify-send} --urgency low --icon media-playback-start --expire-time 1000 'Idle uninhibited'
    else
      ${getExe pkgs.daemonize} \
        -p /tmp/manual-inhibitor-pid \
        ${getExe' pkgs.systemd "systemd-inhibit"} --what idle --who "$USER" --why Manual ${getExe' coreutils "sleep"} infinity
      ${notify-send} --urgency low --icon media-playback-pause --expire-time 1000 'Idle inhibited'
    fi
  '';

  logoutMenu = writeBash "logout-menu.sh" ''
    case "$(echo -en 'Suspend\0icon\x1fsleep\nShutdown\0icon\x1fsystem-shutdown\nReboot\0icon\x1fsystem-reboot\nWindows\0icon\x1fpreferences-system-windows\nLock\0icon\x1fsystem-lock-screen\nLogout\0icon\x1fsystem-log-out' | fuzzel --dmenu --placeholder 'Select action')" in
      Suspend) ${systemctl} suspend ;;
      Shutdown) ${systemctl} poweroff ;;
      Reboot) ${systemctl} reboot ;;
      Windows) ${systemctl} reboot --boot-loader-entry auto-windows ;;
      Lock) ${loginctl} lock-session ;;
      Logout) ${loginctl} terminate-user "$USER" ;;
    esac
  '';
}
