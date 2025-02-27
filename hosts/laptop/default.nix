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

  home-manager.users.${values.mainUser} = {
    programs.mpv = {
      # Disable all the high quality stuff for performance/battery life
      defaultProfiles = mkForce [];
      profiles.anime = mkForce {
        sub-visibility = true;
      };
    };

    wayland.windowManager.sway.config.input."1267:12722:ELAN0647:00_04F3:31B2_Touchpad".natural_scroll = "enabled";
  };

  networking.hostName = "${values.mainUser}-LAPTOP";
  system.stateVersion = "24.05";
}
