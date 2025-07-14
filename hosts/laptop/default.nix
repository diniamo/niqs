{ config, lib, pkgs, ... }: let
  inherit (lib) mkForce;
in {
  imports = [ ./hardware.nix ];

  hardware = {
    graphics.extraPackages = with pkgs; [ intel-vaapi-driver intel-media-driver ];
    intel-gpu-tools.enable = true;
  };
  
  zramSwap.enable = true;

  custom = {
    mobile.enable = true;
    
    sway.settings = ''
      input "1267:12722:ELAN0647:00_04F3:31B2_Touchpad" {
        natural_scroll enabled
      }
    '';
  };

  user.packages = [ pkgs.gmetronome ];

  networking.hostName = "${config.user.name}-LAPTOP";
  system.stateVersion = "24.05";
}
