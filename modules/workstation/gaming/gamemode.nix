{ config, lib, pkgs, ... }: let
  inherit (lib) mkOption types mkIf mkForce getExe getExe';
  inherit (pkgs.writers) writeDash;

  cfg = config.custom.gaming;

  notify-send = getExe pkgs.libnotify;
  pkill = getExe' pkgs.procps "pkill";
  bluetoothctl = getExe' pkgs.bluez "bluetoothctl";

  startScript = writeDash "gamemode-start" ''
    ${pkill} -USR1 --exact dwl
    ${bluetoothctl} power on
    ${cfg.extraStartCommands}

    ${notify-send} --urgency low --app-name Gamemode --icon input-gaming --expire-time 1000 'Optimizations activated'
  '';
  endScript = writeDash "gamemode-end" ''
    ${pkill} -USR2 --exact dwl
    ${bluetoothctl} power off
    ${cfg.extraEndCommands}

    ${notify-send} --urgency low --app-name Gamemode --icon system-shutdown --expire-time 1000 'Optimizations deactivated'
  '';
in {
  options = {
    custom.gaming = {
      extraStartCommands = mkOption {
        description = "Extra commands to run in the start script of gamemode.";
        type = types.lines;
        default = "";
      };
      extraEndCommands = mkOption {
        description = "Extra commands to run in the end script of gamemode.";
        type = types.lines;
        default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;

      settings = {
        general = {
          renice = 20;
          softrealtime = "auto";
        };

        custom = {
          start = startScript.outPath;
          end = endScript.outPath;
        };
      };
    };

    # The start script relies on SWAYSOCK and WAYLAND_DISPLAY,
    # which are imported when the graphical session starts
    systemd.user.services.gamemoded = {
      wantedBy = mkForce [];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };

    user.extraGroups = [ "gamemode" ];
  };
}
