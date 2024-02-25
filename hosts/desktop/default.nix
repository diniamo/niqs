# configuration.nix(5)
# https://search.nixos.org/options
# NixOS manual (`nixos-help`)
{
  config,
  ...
}: let
  inherit (config.modules) values;
in {
  imports = [./hardware.nix];
  networking.hostName = "${values.mainUser}";

  modules.boot.windows_entry = true;

  home-manager.users.${values.mainUser}.wayland.windowManager.hyprland.settings.monitor = [
    "DP-1, 1920x1080@165, 0x0, 1, vrr, 1"
    "DP-2, 1920x1080@60, 1920x0, 1"
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
