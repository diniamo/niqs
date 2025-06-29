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
  swaymsg = getExe' config.programs.sway.package "swaymsg";
in {
  notifyInformation = let
    summary = optionalString custom.mobile.enable "\"$(${cat} /sys/class/power_supply/BAT0/capacity)% - $(${cat} /sys/class/power_supply/BAT0/status)\"";
  in writeDash "notify-information.sh" ''
    if [ -f /tmp/information-notification-id ]; then
      ${notify-send} --replace-id $(${cat} /tmp/information-notification-id) --icon time "$(${date} +%R)" ${summary}
    else
      ${notify-send} --print-id --icon time "$(${date} +%R)" ${summary} > /tmp/information-notification-id
    fi
  '';

  toggleInhibitor = writeDash "toggle-inhibitor.sh" ''
    if kill $(${cat} /tmp/manual-inhibitor-pid 2>/dev/null) 2>/dev/null; then
      rm /tmp/manual-inhibitor-pid
      ${notify-send} --urgency=low --icon=media-playback-start 'Idle uninhibited'
    else
      ${getExe pkgs.daemonize} \
        -p /tmp/manual-inhibitor-pid \
        ${getExe' pkgs.systemd "systemd-inhibit"} --what=idle --who="$USER" --why=Manual ${getExe' coreutils "sleep"} infinity
      ${notify-send} --urgency=low --icon=media-playback-pause 'Idle inhibited'
    fi
  '';

  logoutMenu = writeBash "logout-menu.sh" ''
    case "$(echo -en 'Suspend\0icon\x1fsleep\nShutdown\0icon\x1fsystem-shutdown\nReboot\0icon\x1fsystem-reboot\nWindows\0icon\x1fpreferences-system-windows\nLock\0icon\x1fsystem-lock-screen\nLogout\0icon\x1fsystem-log-out' | fuzzel --dmenu)" in
      Suspend) ${systemctl} suspend ;;
      Shutdown) ${systemctl} poweroff ;;
      Reboot) ${systemctl} reboot ;;
      Windows) ${systemctl} reboot --boot-loader-entry=auto-windows ;;
      Lock) ${loginctl} lock-session ;;
      Logout) ${loginctl} terminate-user "$USER" ;;
    esac
  '';
}
