{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.media;
in {
  options = {
    custom.media.enable = mkEnableOption "media services";
  };

  config = mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
      };

      shokoserver = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
