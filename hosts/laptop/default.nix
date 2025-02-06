{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;

  inherit (config) values;
in {
  imports = [./hardware.nix];

  custom.mobile.enable = true;

  environment.systemPackages = [pkgs.gmetronome];

  hardware = {
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-media-driver];
    intel-gpu-tools.enable = true;
  };

  zramSwap.enable = true;

  # pipewire-pulse kept getting killed by God himself, and most programs use pulseaudio anyway
  services = {
    pipewire.enable = lib.mkForce false;
    pulseaudio.enable = true;
  };

  home-manager.users.${values.mainUser} = {
    programs.mpv = {
      config.ao = "pulse";
      # This laptop isn't that strong, I might have to disable some other stuff as well,
      # if it still struggles
      profiles.anime.script = mkForce null;
    };
  };

  networking.hostName = "${values.mainUser}-LAPTOP";
  system.stateVersion = "24.05";
}
