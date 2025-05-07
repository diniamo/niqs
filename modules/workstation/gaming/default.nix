{
  inputs,
  lib,
  config,
  pkgs,
  flakePkgs,
  ...
}: let
  inherit (lib) getExe getExe' mkForce mkEnableOption mkOption;
  inherit (lib.types) lines;
  inherit (pkgs.writers) writeDash;

  powerprofilesctl = getExe pkgs.power-profiles-daemon;
  notify-send = getExe pkgs.libnotify;
  swaymsg = getExe' pkgs.sway "swaymsg";

  startScript = writeDash "gamemode-start" ''
    ${powerprofilesctl} set performance
    ${swaymsg} 'allow_tearing yes'
    ${swaymsg} 'input * scroll_method none'
    ${getExe pkgs.daemonize} -p /tmp/game-mode-wayhibitor-pid ${getExe flakePkgs.wayhibitor.default}
    ${cfg.extraStartCommands}

    ${notify-send} --urgency=low --app-name='Gamemode' --icon=input-gaming 'Optimizations activated'
  '';
  endScript = writeDash "gamemode-end" ''
    ${powerprofilesctl} set balanced
    ${swaymsg} 'allow_tearing no'
    ${swaymsg} 'input * scroll_method on_button_down'
    ${getExe' pkgs.util-linux "kill"} "$(${getExe' pkgs.coreutils "cat"} /tmp/game-mode-wayhibitor-pid)"
    ${cfg.extraEndCommands}

    ${notify-send} --urgency=low --app-name='Gamemode' --icon=system-shutdown 'Optimizations deactivated'
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

  config = lib.mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"];

    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.graphics.enable32Bit = true;

    environment.systemPackages = [pkgs.umu-launcher];

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;

        extraPackages = [pkgs.openssl_1_1];
        extraCompatPackages = [pkgs.proton-ge-bin];
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
      wantedBy = lib.mkForce [];
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  };
}
