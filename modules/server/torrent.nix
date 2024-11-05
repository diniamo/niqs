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
        package = pkgs.transmission_4;

        openRPCPort = true;
        webHome = pkgs.flood-for-transmission;
        credentialsFile = "/var/lib/transmission/settings.json";

        settings = {
          rpc-bind-address = "0.0.0.0";
          rpc-whitelist-enabled = false;
          anti-brute-force-enabled = true;
          rpc-authentication-required = true;

          rename-partial-files = true;
          incomplete-dir-enabled = false;
        };
      };

      prowlarr = {
        enable = true;
        openFirewall = true;
      };

      # https://github.com/NixOS/nixpkgs/issues/332776
      # https://github.com/FlareSolverr/FlareSolverr/issues/1318
      # flaresolverr.enable = true;
    };
  };
}
