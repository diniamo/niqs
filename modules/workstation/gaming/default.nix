{ lib, config, pkgs, ... }: let
  inherit (lib) getExe getExe' mkForce mkEnableOption mkOption mkIf;
  inherit (lib.types) lines;
  inherit (pkgs.writers) writeDash;

  powerprofilesctl = getExe pkgs.power-profiles-daemon;
  notify-send = getExe pkgs.libnotify;
  swaymsg = getExe' config.programs.sway.package "swaymsg";

  startScript = writeDash "gamemode-start" ''
    ${powerprofilesctl} set performance
    ${swaymsg} 'allow_tearing yes'
    ${swaymsg} 'input * scroll_method none'
    ${getExe pkgs.daemonize} \
      -p /tmp/gamemode-inhibitor-pid \
      ${getExe' pkgs.systemd "systemd-inhibit"} --what=idle --who=Gamemode --why='Game open' ${getExe' pkgs.coreutils "sleep"} infinity
    ${cfg.extraStartCommands}

    ${notify-send} --urgency low --app-name Gamemode --icon input-gaming --expire-time 1000 'Optimizations activated'
  '';
  endScript = writeDash "gamemode-end" ''
    ${powerprofilesctl} set balanced
    ${swaymsg} 'allow_tearing no'
    ${swaymsg} 'input * scroll_method on_button_down'
    ${getExe' pkgs.util-linux "kill"} "$(${getExe' pkgs.coreutils "cat"} /tmp/gamemode-inhibitor-pid)"
    ${cfg.extraEndCommands}

    ${notify-send} --urgency low --app-name Gamemode --icon system-shutdown --expire-time 1000 'Optimizations deactivated'
  '';

  cfg = config.custom.gaming;
in {
  imports = [
    ./pipewire-low-latency.nix
    ./platform-optimizations.nix
  ];

  options = {
    custom.gaming = {
      enable = mkEnableOption "Enable the gaming module";

      extraStartCommands = mkOption {
        description = "Extra commands to run in the start script of gamemode.";
        type = lines;
        default = "";
      };

      extraEndCommands = mkOption {
        description = "Extra commands to run in the end script of gamemode.";
        type = lines;
        default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.mangohud.enable = true;

    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.graphics.enable32Bit = true;

    environment = {
      systemPackages = [(pkgs.lutris.override {
        # I can still use the Steam from my environment, which is what I want, since it has wrapper options set.
        steamSupport = false;
        # For winetricks/zenity
        extraLibraries = pkgs: with pkgs; [
          gtk4
          libadwaita
       ];
      })];

      sessionVariables.PROTON_ENABLE_WAYLAND = 1;
    };

    home.files.".local/share/lutris/runners/proton/GE-Proton".source = pkgs.proton-ge-bin.steamcompattool;

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;

        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            renice = 15;
            softrealtime = "auto";
          };

          custom = {
            start = startScript.outPath;
            end = endScript.outPath;
          };
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
  };
}
