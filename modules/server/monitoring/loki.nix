{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.custom.monitoring;
in {
  config = mkIf cfg.enable {
    services.loki = {
      enable = true;

      configuration = {
        auth_enabled = false;
        server.http_listen_port = 3030;
      };
    };
  };
}
