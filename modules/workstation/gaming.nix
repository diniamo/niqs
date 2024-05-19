{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;

  inherit (lib) mkIf getExe getExe' mkEnableOption;
  inherit (pkgs) writeShellScript;

  hyprctl = "'${getExe' flakePkgs.hyprland.default "hyprctl"}' -i 0";
  powerprofilesctl = getExe pkgs.power-profiles-daemon;
  notify-send = getExe pkgs.libnotify;

  startScript = writeShellScript "gamemode-start" ''
    ${hyprctl} --batch 'keyword animations:enabled 0; keyword misc:vfr 0'
    ${powerprofilesctl} set performance
    ${notify-send} -u low -a 'Gamemode' 'Optimizations activated'
  '';
  endScript = writeShellScript "gamemode-end" ''
    ${hyprctl} --batch 'keyword animations:enabled 1; keyword misc:vfr 1'
    ${powerprofilesctl} set balanced
    ${notify-send} -u low -a 'Gamemode' 'Optimizations deactivated'
  '';

  cfg = config.modules.gaming;
in {
  imports = [
    pipewireLowLatency
    platformOptimizations
  ];

  options = {
    modules.gaming = {
      enable = mkEnableOption "Enable the gaming module";
    };
  };

  config = mkIf cfg.enable {
    services.pipewire.lowLatency.enable = true;
    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.opengl.driSupport32Bit = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs = {
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        gamescopeSession.enable = true;

        protontricks.enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
      };

      gamescope = {
        enable = true;
        capSysNice = true;
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
  };
}
