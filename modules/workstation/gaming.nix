{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs) writeShellScript;

  inherit (inputs) nix-gaming;
  inherit (nix-gaming) nixosModules;

  startScript = writeShellScript "gamemode-start" ''
    powerprofilesctl set performance
    notify-send -a "Gamemode" "Optimizations activated"
  '';
  endScript = writeShellScript "gamemode-end" ''
    powerprofilesctl set balanced
    notify-send -a "Gamemode" "Optimizations deactivated"
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
