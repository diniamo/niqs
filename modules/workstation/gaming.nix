{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe mkEnableOption;
  inherit (pkgs) writeShellScript;

  inherit (inputs) nix-gaming;
  inherit (nix-gaming) nixosModules;

  startScript = writeShellScript "gamemode-start" ''
    hyprctl --batch 'keyword animations:enabled 0 ; keyword misc:vfr 0'
    ${getExe pkgs.power-profiles-daemon} set performance
    ${getExe pkgs.libnotify} -a "Gamemode" "Optimizations activated"
  '';
  endScript = writeShellScript "gamemode-end" ''
    hyprctl --batch 'keyword animations:enabled 1 ; keyword misc:vfr 1'
    ${getExe pkgs.power-profiles-daemon} set balanced
    ${getExe pkgs.libnotify} -a "Gamemode" "Optimizations deactivated"
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
    nixpkgs.config.allowUnfree = true;

    services.pipewire.lowLatency.enable = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;

    environment.systemPackages = [pkgs.mangohud];

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
