{
  pkgs,
  lib,
  config,
  flakePkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption types mkOption getExe';
  inherit (pkgs) writeShellScript;
  inherit (flakePkgs.niqspkgs) bencode-pretty;

  script = writeShellScript "convert-qbittorrent-savepaths" ''
    # Arguments: 1 - BT_backup path
    #            2 - from path
    #            3 - to path
    tmp=$(mktemp)

    for file in "$1"/*.fastresume; do
      cat "$file" | ${getExe' bencode-pretty "bencode_pretty"} | sed "s,$2,$3,g" | ${getExe' bencode-pretty "bencode_unpretty"} > "$tmp"
      cp "$tmp" "$file"
    done
  '';

  cfg = config.modules.qbittorrent.convertSavePaths;
in {
  options = {
    modules.qbittorrent = {
      convertSavePaths = {
        enable = mkEnableOption "Convert savepaths from and to Windows on startup and shutdown respectively";
        btBackupPath = mkOption {
          type = types.nonEmptyStr;
          description = "Path to the BT_Backup directory";
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
  };

  config = {
    environment.systemPackages = [pkgs.qbittorrent];

    systemd.services.convertQbittorrentSavepaths = mkIf cfg.enable {
      description = "Convert the qBittorrent savepaths on startup and shutdown";
      after = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${script} ${cfg.btBackupPath} ${cfg.windowsMatchPath} ${cfg.unixPath}";
        ExecStop = "${script} ${cfg.btBackupPath} ${cfg.unixPath} ${cfg.windowsPath}";
      };

      wantedBy = ["multi-user.target"];
    };
  };
}
