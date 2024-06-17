{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;

  inherit (config) values;
in {
  imports = [./hardware.nix];

  networking.hostName = "${values.mainUser}-THINKPAD";
  networking.networkmanager.enable = true;

  services = {
  power-profiles-daemon.enable = lib.mkForce false;
    auto-cpufreq.enable = true;
    thermald.enable = true;
    # The CPU stuff conflicts with auto-cpufreq.
    # Should I bother with this?
    # tlp = {
    #   enable = true;
    #   settings = {
    #     TLP_ENABLE = 1;
    #
    #     DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
    #     DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth nfc wwan";
    #     DEVICES_TO_DISABLE_ON_SHUTDOWN = "bluetooth nfc wifi wwan";
    #     DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wifi wwan";
    #
    #     DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
    #     DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
    #   };
    # };
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
