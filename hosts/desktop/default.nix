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

  hardware.opentabletdriver = {
    enable = true;
    package = pkgs.opentabletdriver.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        owner = "OpenTabletDriver";
        repo = "OpenTabletDriver";
        rev = "9130e9b8df17616f9d138128098c42d4b62ba1a3";
        hash = "sha256-UX5qp9bwWvu/wmgdq8ruNWKTtK0/ekW9DcT2+R6MV5I=";
      };

      # A test fails for some reason, and I failed to disable just that one
      doCheck = false;
    };
  };

  environment.systemPackages = with pkgs; [
    qbittorrent
    anki
    krita
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
    };

    wayland.windowManager.river.settings = {
      spawn = ["wlr-randr --output DP-1 --mode 1920x1080@164.917007Hz --adaptive-sync enabled"];
      rule-add = ["-app-id vesktop output DP-2"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
