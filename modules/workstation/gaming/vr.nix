{ config, lib, flakePkgs, ... }: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.gaming;
in {
  options = {
    custom.gaming = {
      vr = mkEnableOption "VR";
    };
  };

  config = mkIf (cfg.enable && cfg.vr) {
    # Oculus Rift CV1
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="2833", MODE="0666", GROUP="plugdev"
    '';

    home.files.".local/share/Steam/steamapps/common/SteamVR/drivers/openhmd".source = flakePkgs.niqspkgs.steamvr-openhmd-thaytan;
  };
}
