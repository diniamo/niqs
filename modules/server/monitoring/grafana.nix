{ lib, pkgs, config, ... }: let
  inherit (lib) mkIf singleton;
  inherit (pkgs) linkFarm fetchurl;

  cfg = config.custom.monitoring;
in {
  config = mkIf cfg.enable {
    services = {
      grafana = {
        enable = true;

        openFirewall = true;
        settings.server.http_addr = "0.0.0.0";

        provision = {
          enable = true;

          dashboards.settings.providers =
            singleton
            {
              options.path = linkFarm "grafana-dashboards" [
                {
                  name = "node-exporter-full.json";
                  path = fetchurl {
                    url = "https://grafana.com/api/dashboards/1860/revisions/37/download";
                    hash = "sha256-1DE1aaanRHHeCOMWDGdOS1wBXxOF84UXAjJzT5Ek6mM=";
                  };
                }
                # {
                #   name = "loki-promtail.json";
                #   path = fetchurl {
                #     url = "https://grafana.com/api/dashboards/14055/revisions/5/download";
                #     hash = "sha256-9vfUGpypFNKm9T1F12Cqh8TIl0x3jSwv2fL9HVRLt3o=";
                #   };
                # }
                {
                  name = "smart-hdd.json";
                  path = ./dashboards/smart-hdd.json;
                }
              ];

              datasources.settings.datasources = [
                {
                  name = "Prometheus";
                  type = "prometheus";
                  access = "proxy";
                  url = "http://127.0.0.1:${toString config.services.prometheus.port}";
                  isDefault = true;
                }
                # {
                #   name = "Loki";
                #   type = "Loki";
                #   access = "proxy";
                #   url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}";
                # }
              ];
            };
        };
      };
    };
  };
}
