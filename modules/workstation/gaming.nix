{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) getExe getExe';
  inherit (pkgs.writers) writeDash;
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;

  powerprofilesctl = getExe pkgs.power-profiles-daemon;
  notify-send = getExe pkgs.libnotify;
  swaymsg = getExe' pkgs.sway "swaymsg";

  startScript = writeDash "gamemode-start" ''
    ${powerprofilesctl} set performance
    ${swaymsg} 'allow_tearing yes'

    ${notify-send} --urgency=low --app-name='Gamemode' --icon=input-gaming 'Optimizations activated'
  '';
  endScript = writeDash "gamemode-end" ''
    ${swaymsg} 'allow_tearing no'
    ${powerprofilesctl} set balanced

    ${notify-send} --urgency=low --app-name='Gamemode' --icon=system-shutdown 'Optimizations deactivated'
  '';

  cfg = config.custom.gaming;
in {
  imports = [
    pipewireLowLatency
    platformOptimizations
  ];

  options = {
    custom.gaming.enable = lib.mkEnableOption "Enable the gaming module";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"];

    services.pipewire.lowLatency.enable = true;
    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.graphics.enable32Bit = true;

    environment.systemPackages = [pkgs.umu-launcher];

    programs = {
      steam = {
        enable = true;

        extraPackages = [pkgs.openssl_1_1];
        extraCompatPackages = [pkgs.proton-ge-bin];

        platformOptimizations.enable = true;
        protontricks.enable = true;
      };

      # gamescope = {
      #   enable = true;
      #   capSysNice = true;
      # };

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
  };
}
