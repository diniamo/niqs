{
  config,
  pkgs,
  ...
}: let
  inherit (config) values;
in {
  imports = [./hardware.nix];

  custom = {
    boot.secure = true;
    boot.windowsEntry = true;
    nvidia.enable = true;
    gaming.enable = true;
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    qbittorrent
  ];

  networking.hostName = "${values.mainUser}-PC";

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-1, 1920x1080@165, 0x0, 1, vrr, 2"
        "DP-2, 1920x1080@60, 1920x0, 1"
      ];
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-2, default:true"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
      ];
      windowrule = ["workspace 5, vesktop"];
      exec-once = ["vesktop"];
    };

    wayland.windowManager.river.settings = {
      spawn = [
        "wlr-randr --output DP-1 --mode 1920x1080@164.917007Hz --adaptive-sync enabled"

        "vesktop"
      ];
      rule-add = ["-app-id vesktop output DP-2"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
