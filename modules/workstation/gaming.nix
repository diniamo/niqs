{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (pkgs.writers) writeDash;
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;

  hyprctl = "${lib.getExe' flakePkgs.hyprland.default "hyprctl"} -i 0";
  powerprofilesctl = lib.getExe pkgs.power-profiles-daemon;
  notify-send = lib.getExe pkgs.libnotify;

  startScript = writeDash "gamemode-start" ''
    ${hyprctl} --batch "\
      keyword animations:enabled false; \
      keyword decoration:blur:enabled false; \
      keyword decoration:shadow:enabled false; \
      keyword misc:vfr false; \
      keyword general:allow_tearing true; \
      keyword render:direct_scanout true; \
      keyword input:scroll_method no_scroll"
    ${powerprofilesctl} set performance
    ${notify-send} --urgency=low --app-name='Gamemode' --icon=input-gaming 'Optimizations activated'
    dunstctl set-paused true
  '';
  endScript = writeDash "gamemode-end" ''
    dunstctl set-paused false
    ${hyprctl} reload
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
