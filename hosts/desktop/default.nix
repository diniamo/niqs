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
    
    gaming = {
      enable = true;
      extraStartCommands = "swaymsg output DP-1 adadptive_sync on";
      extraEndCommands = "swaymsg output DP-1 adadptive_sync off";
    };
  };

  hardware.opentabletdriver.enable = true;

  environment.systemPackages = with pkgs; [
    qbittorrent
    anki
    krita
  ];

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.sway = {
      config = {
        output = {
          DP-1 = {
            mode = "1920x1080@165Hz";
            position = "0 0";
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
            output = "DP-1";
            workspace = "2";
          }
          {
            output = "DP-1";
            workspace = "3";
          }
          {
            output = "DP-1";
            workspace = "4";
          }
          {
            output = "DP-2";
            workspace = "5";
          }
          {
            output = "DP-1";
            workspace = "6";
          }
          {
            output = "DP-1";
            workspace = "7";
          }
          {
            output = "DP-1";
            workspace = "8";
          }
          {
            output = "DP-1";
            workspace = "9";
          }
        ];
      };

      # This doesn't work for some reason
      extraConfig = "focus output DP-1";
    };
  };

  networking.hostName = "${values.mainUser}-PC";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
