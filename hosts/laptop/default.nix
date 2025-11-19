{ config, pkgs, ... }: {
  imports = [ ./hardware.nix ];

  hardware = {
    graphics.extraPackages = with pkgs; [ intel-vaapi-driver intel-media-driver ];
    intel-gpu-tools.enable = true;
  };

  zramSwap.enable = true;

  custom.mobile.enable = true;

  networking.hostName = "${config.user.name}-LAPTOP";
  system.stateVersion = "24.05";
}
