{
  pkgs,
  lib,
  config,
  customPkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs) writeShellScript;

  bencodeBin = "${customPkgs.bencode-pretty}/bin";
  script = writeShellScript "convert-qbittorrent-savepaths" ''
    # Arguments: 1 - BT_backup path
    #            2 - from path
    #            3 - to path
    tmp=$(mktemp)

    for file in "$1"/*.fastresume; do
      cat "$file" | ${bencodeBin}/bencode_pretty | sed "s,$2,$3,g" | ${bencodeBin}/bencode_unpretty > "$tmp"
      cp "$tmp" "$file"
    done
  '';

  cfg = config.modules.general.qbittorrent.convertSavePaths;
in {
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
}
