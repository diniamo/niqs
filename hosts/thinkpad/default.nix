{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;

  brightnessctl = lib.getExe pkgs.brightnessctl;

  inherit (config) values;
in {
  imports = [./hardware.nix];

  networking.hostName = "${values.mainUser}-THINKPAD";
  networking.networkmanager.enable = true;

  services = {
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
      binde = [
        ", XF86MonBrightnessUp, exec, ${brightnessctl} set 2%+"
        ", XF86MonBrightnessDown, exec, ${brightnessctl} set 2%- -n"
      ];
    };
  };

  system.stateVersion = "24.05";
}
