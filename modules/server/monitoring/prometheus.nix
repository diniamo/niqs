{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  inherit (config.services.prometheus) exporters;
  cfg = config.custom.monitoring;
in {
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;

      exporters = {
        node = {
          enable = true;
          port = 9101;
          enabledCollectors = ["systemd"];
        };

        smartctl = {
          enable = true;
          port = 9102;
        };
      };

      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{targets = ["localhost:${toString exporters.node.port}"];}];
        }
        {
          job_name = "smartctl";
          static_configs = [{targets = ["localhost:${toString exporters.smartctl.port}"];}];
        }
      ];
    };
  };
}
