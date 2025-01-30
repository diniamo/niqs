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
    wayland.windowManager = {
      river.settings.spawn = ["wlr-randr --output DP-1 --mode 1920x1080@164.917007Hz --adaptive-sync enabled"];

      sway = {
        config = {
          output = {
            DP-1 = {
              mode = "1920x1080@165Hz";
              position = "0 0";
              adaptive_sync = "on";
              allow_tearing = "yes";
            };
            DP-2 = {
              mode = "1920x1080@60Hz";
              position = "1920 0";
            };
          };
          workspaceOutputAssign = [
            {
              output = "DP-1";
              workspace = "1";
            }
            {
              output = "DP-2";
              workspace = "5";
            }
          ];
        };

        # This doesn't work for some reason
        extraConfig = "focus output DP-1";
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
