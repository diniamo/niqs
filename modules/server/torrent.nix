{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.torrent;
in {
  options = {
    custom.torrent.enable = mkEnableOption "torrent services";
  };

  config = mkIf cfg.enable {
    services = {
      transmission = {
        enable = true;

        openRPCPort = true;
        webHome = pkgs.flood-for-transmission;
        credentialsFile = "/var/lib/transmission/settings.json";
        downloadDirPermissions = "775";

        settings = {
          rpc-bind-address = "0.0.0.0";
          rpc-whitelist-enabled = false;
          anti-brute-force-enabled = true;
          rpc-authentication-required = true;

          rename-partial-files = false;
          incomplete-dir-enabled = true;
        };
      };

      flaresolverr.enable = true;
    };
  };
}
