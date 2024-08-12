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

  networking = {
    hostName = "${values.mainUser}-THINKPAD";
    networkmanager = {
      enable = true;
      plugins = mkForce [];
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  services = {
    # It keeps getting killed by God himself
    # and programs keep trying to use it even if they have a fallback
    pipewire.pulse.enable = lib.mkForce false;

    # For remote rebuilding
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

  zramSwap.enable = true;
  hardware = {
    graphics.extraPackages = with pkgs; [intel-vaapi-driver intel-media-driver];
    intel-gpu-tools.enable = true;
  };

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      animations.enabled = mkForce false;
      decoration = {
        blur.enabled = mkForce false;
        drop_shadow = mkForce false;
      };
    };
  };

  system.stateVersion = "24.05";
}
