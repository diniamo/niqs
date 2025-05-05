{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkForce mkIf;
in {
  options.custom.mobile.enable = mkEnableOption "configuration for mobile devices";

  config = mkIf config.custom.mobile.enable {
    environment.systemPackages = [pkgs.brightnessctl];

    networking.networkmanager = {
      enable = true;
      plugins = mkForce [];
    };

    services = {
      # For remote rebuilding, since mobile devices are usually weak
      openssh = {
        enable = true;
        startWhenNeeded = true;
        settings.PermitRootLogin = "yes";
      };

      power-profiles-daemon.enable = lib.mkForce false;
      auto-cpufreq.enable = true;
      thermald.enable = true;
    };
  };
}
