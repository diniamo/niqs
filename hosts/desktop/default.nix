{
  config,
  customPkgs,
  ...
}: let
  inherit (config.modules) values;
in {
  imports = [./hardware.nix];
  networking.hostName = "${values.mainUser}";

  modules = {
    boot.windows_entry = true;
    general.gaming.enable = true;
  };

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-1, 1920x1080@165, 0x0, 1, vrr, 1"
        "DP-2, 1920x1080@60, 1920x0, 1"
      ];
      exec-once = ["vesktop"];
    };
  };

  # HACK: this is only for testing
  environment.systemPackages = [customPkgs.bencode-pretty];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
