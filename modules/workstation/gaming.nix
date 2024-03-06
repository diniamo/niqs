{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (pkgs) writeShellScript;

  inherit (inputs) nix-gaming;
  inherit (nix-gaming) nixosModules;

  startScript = writeShellScript "gamemode-start" ''
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
    ${getExe pkgs.libnotify} -a "Gamemode" "Optimizations activated"
  '';
  endScript = writeShellScript "gamemode-end" ''
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
    ${getExe pkgs.libnotify} -a "Gamemode" "Optimizations deactivated"
  '';
in {
  imports = [
    nixosModules.pipewireLowLatency
    nixosModules.steamCompat
  ];

  config = mkIf config.modules.general.gaming.enable {
    nixpkgs.config.allowUnfree = true;

    services.pipewire.lowLatency.enable = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      extraCompatPackages = [flakePkgs.nix-gaming.proton-ge];
    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    programs.gamemode = {
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
}
