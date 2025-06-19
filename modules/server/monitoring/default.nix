{ lib, ... }: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./prometheus.nix
    ./grafana.nix
    # ./loki.nix # exits with some random error
  ];

  options = {
    custom.monitoring.enable = mkEnableOption "monitoring services";
  };
}
