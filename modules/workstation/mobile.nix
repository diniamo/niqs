{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkForce mkDefault mkIf;
in {
  options.modules.mobile.enable = mkEnableOption "configuration for mobile devices";

  config = mkIf config.modules.mobile.enable {
    environment.systemPackages = [pkgs.brightnessctl];

    networking.networkmanager = {
      enable = true;
      plugins = mkForce [];
    };

    zramSwap.enable = mkDefault true;

    services = {
      # For remote rebuilding, mobile devices are usually weak
      openssh = {
        enable = true;
        startWhenNeeded = true;
        settings = {
          PermitRootLogin = "yes";
        };
      };

      power-profiles-daemon.enable = lib.mkForce false;
      auto-cpufreq.enable = true;
      thermald.enable = true;
    };

    home-manager.users.${config.values.mainUser} = {
      wayland.windowManager.hyprland.settings = {
        animations.enabled = mkForce false;
        decoration = {
          blur.enabled = mkForce false;
          drop_shadow = mkForce false;
        };
      };
    };
  };
}
