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
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
    ${getExe pkgs.libnotify} -a "Gamemode" "Optimizations activated"
  '';
  endScript = writeShellScript "gamemode-end" ''
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
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

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      extraCompatPackages = [flakePkgs.nix-gaming.proton-ge];
    };
    programs.gamescope = {
      enable = true;
      package = let
        inherit (lib) throwIf versionOlder;
        inherit (pkgs) gamescope fetchFromGitHub;
      in
        throwIf (versionOlder "3.14.2" gamescope.version) "A new version of gamescope has been released, remove this override" (gamescope.overrideAttrs (_: oldAttrs: {
          src = fetchFromGitHub {
            owner = "ValveSoftware";
            repo = "gamescope";
            rev = "f9386a769765958b35d996d4e25f9238b757e7d0";
            fetchSubmodules = true;
            hash = "sha256-5JIC5zZe6IiZOA82nNum7in/+7LpeRu9I7tnJTOwqWo=";
          };

          buildInputs = oldAttrs.buildInputs ++ [pkgs.libdecor];
        }));
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
