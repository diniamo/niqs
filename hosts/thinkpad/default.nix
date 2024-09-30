{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) values;
in {
  imports = [./hardware.nix];

  networking.hostName = "${values.mainUser}-LAPTOP";
  modules.mobile.enable = true;

  environment.systemPackages = [pkgs.gmetronome];

  hardware = {
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-media-driver];
    intel-gpu-tools.enable = true;
  };

  # pipewire-pulse kept getting killed by God himself, and most programs use pulseaudio anyway
  services.pipewire.enable = lib.mkForce false;
  hardware.pulseaudio.enable = true;

  home-manager.users.${values.mainUser} = {
    programs.mpv.config.ao = "pulse";
    programs.jerry.config.player_arguments = lib.mkForce "";
  };

  system.stateVersion = "24.05";
}
