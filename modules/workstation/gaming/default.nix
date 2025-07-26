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

    ${notify-send} --urgency=low --app-name='Gamemode' --icon=input-gaming 'Optimizations activated'
  '';
  endScript = writeDash "gamemode-end" ''
    ${powerprofilesctl} set balanced
    ${swaymsg} 'allow_tearing no'
    ${swaymsg} 'input * scroll_method on_button_down'
    ${getExe' pkgs.util-linux "kill"} "$(${getExe' pkgs.coreutils "cat"} /tmp/gamemode-inhibitor-pid)"
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

  config = mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

    custom.mangohud.enable = true;

    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.graphics.enable32Bit = true;

    environment = {
      systemPackages = [ pkgs.umu-launcher ];
      sessionVariables.PROTON_ENABLE_WAYLAND = 1;
    };

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;

        extraPackages = [ pkgs.openssl_1_1 ];
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
    
    home.files."Games/proton" = {
      name = "games-proton";
      text = toString pkgs.proton-ge-bin.steamcompattool;
    };
  };
}
