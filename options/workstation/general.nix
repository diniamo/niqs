{lib, ...}: let
  inherit (lib) mkOption types mkEnableOption;
in {
  options.modules.general = {
    xdgDesktopPortal = mkOption {
      type = types.enum ["wlr" "gtk" "xapp" "gnome" "cosmic" "hyprland" "kde" "lxqt" "pantheon"];
      description = "The default xdg desktop portal to use";
      default = "gtk";
    };

    gaming.enable = mkEnableOption "Enable gaming related stuff";

    qbittorrent.convertSavePaths = {
      enable = mkEnableOption "Convert savepaths from and to Windows on startup and shutdown respectively";
      btBackupPath = mkOption {
        type = types.nonEmptyStr;
        description = "Path to the BT_Backup";
      };
      windowsMatchPath = mkOption {
        type = types.nonEmptyStr;
        description = "A plain sed pattern to match for replacing the Windows path";
      };
      windowsPath = mkOption {
        type = types.nonEmptyStr;
        description = "Path to the torrent folder on Windows";
      };
      unixPath = mkOption {
        type = types.nonEmptyStr;
        description = "Path to the torrent folder on Unix";
      };
    };
  };
}
