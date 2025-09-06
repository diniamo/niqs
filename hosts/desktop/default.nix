{ config, pkgs, lib, ... }: let
  inherit (lib) getExe';

  swaymsg = getExe' config.programs.sway.package "swaymsg";
in {
  imports = [ ./hardware.nix ];

  custom = {
    boot.secure = true;
    nvidia.enable = true;

    gaming = {
      enable = true;
      extraStartCommands = "${swaymsg} output DP-1 adadptive_sync on";
      extraEndCommands = "${swaymsg} output DP-1 adadptive_sync off";
    };

    mpv.profiles.anime = {
      # 15-15 GiB
      demuxer-max-bytes = 16106127360;
      demuxer-max-back-bytes = 16106127360;
    };
  };

  hardware.opentabletdriver.enable = true;

  user.packages = with pkgs; [
    transmission_4-gtk
    anki
    krita
  ];

  custom.sway.settings = ''
    workspace "1" output "DP-1"
    workspace "2" output "DP-1"
    workspace "3" output "DP-1"
    workspace "4" output "DP-1"
    workspace "5" output "DP-2"
    workspace "6" output "DP-1"
    workspace "7" output "DP-1"
    workspace "8" output "DP-1"
    workspace "9" output "DP-1"

    output "DP-1" {
      mode 1920x1080@165Hz
      position 0 0
      allow_tearing yes
    }

    output "DP-2" {
      mode 1920x1080@60Hz
      position 1920 0
    }

    focus output DP-1
  '';

  networking = {
    hostName = "${config.user.name}-PC";
    firewall.allowedTCPPorts = [ 5300 ];
  };

  system.stateVersion = "23.11";
}
