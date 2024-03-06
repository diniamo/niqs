{config, ...}: let
  inherit (config.modules) values;
in {
  imports = [./hardware.nix];

  modules = {
    boot.windows_entry = true;
    general = {
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
  };

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-1, 1920x1080@165, 0x0, 1, vrr, 1"
        "DP-2, 1920x1080@60, 1920x0, 1"
      ];
      workspace = [
        "1, monitor:DP-1,default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
        "10, monitor:DP-2,default:true"
      ];
      windowrule = [
        "workspace 10,vesktop"
      ];
      exec-once = ["vesktop"];
    };
  };

  networking.hostName = "${values.mainUser}";
  boot.tmp.useTmpfs = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
