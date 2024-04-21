{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe getExe' mkEnableOption;
  inherit (pkgs) writeShellScript;

  inherit (inputs) nix-gaming;
  inherit (nix-gaming) nixosModules;

  hyprctl = getExe' flakePkgs.hyprland.default "hyprctl";
  powerprofilesctl = getExe pkgs.power-profiles-daemon;
  notify-send = getExe pkgs.libnotify;

  startScript = writeShellScript "gamemode-start" ''
    ${hyprctl} --batch 'keyword animations:enabled 0 ; keyword misc:vfr 0'
    ${powerprofilesctl} set performance
    ${notify-send} -a "Gamemode" "Optimizations activated"
  '';
  endScript = writeShellScript "gamemode-end" ''
    ${hyprctl} --batch 'keyword animations:enabled 1 ; keyword misc:vfr 1'
    ${powerprofilesctl} set balanced
    ${notify-send} -a "Gamemode" "Optimizations deactivated"
  '';

  cfg = config.modules.gaming;
in {
  imports = [
    nixosModules.pipewireLowLatency
  ];

  options = {
    modules.gaming = {
      enable = mkEnableOption "Enable the gaming module";
    };
  };

  config = mkIf cfg.enable {
    services.pipewire.lowLatency.enable = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;

    environment.systemPackages = [pkgs.mangohud];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;

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
          custom = {
            start = startScript.outPath;
            end = endScript.outPath;
          };
        };
      };
    };
  };
}
