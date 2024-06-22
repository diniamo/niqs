{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) values;
in {
  imports = [./hardware.nix];

  modules = {
    boot.secure = true;
    boot.windowsEntry = true;
    nvidia.enable = true;
    gaming.enable = true;
    qbittorrent.convertSavePaths = {
      enable = true;
      btBackupPath = "/torrent/BT_backup";
      # 8\ -(nix escaping)> 4\ -(systemd shell escaping)> 2\ (escape in sed)
      windowsMatchPath = "E:[/\\\\\\\\]complete";
      windowsPath = "E:/complete";
      unixPath = "/torrent/complete";
    };
  };

  networking.hostName = "${values.mainUser}-PC";
  hardware.pulseaudio.enable = false;
  # services.xserver = {
  #   enable = true;
  #   displayManager.startx.enable = true;
  #   desktopManager.gnome.enable = true;
  # };
  boot.kernelPackages = pkgs.linuxPackages;

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      misc.background_color = lib.mkForce "0x2E3034";
      monitor = [
        "DP-1, 1920x1080@165, 0x0, 1, vrr, 2"
        "DP-2, 1920x1080@60, 1920x0, 1"
      ];
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
        "10, monitor:DP-2, default:true"
      ];
      windowrule = [
        "workspace 10, vesktop"
        "opacity 1 0.9, vesktop"
      ];
      exec-once = ["vesktop"];
    };

    xsession.windowManager.i3.config = {
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-0";
        }
        {
          workspace = "2";
          output = "DP-0";
        }
        {
          workspace = "3";
          output = "DP-0";
        }
        {
          workspace = "4";
          output = "DP-0";
        }
        {
          workspace = "5";
          output = "DP-0";
        }
        {
          workspace = "6";
          output = "DP-0";
        }
        {
          workspace = "7";
          output = "DP-0";
        }
        {
          workspace = "8";
          output = "DP-0";
        }
        {
          workspace = "9";
          output = "DP-0";
        }
        {
          workspace = "10";
          output = "DP-3";
        }
      ];
      startup = [{command = "xrandr --output DP-0 --mode 1920x1080 --rate 165";}];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
