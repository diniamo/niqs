{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  inherit (config) services;
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

      shoko = {
        enable = true;
        openFirewall = true;
      };

      sonarr = {
        enable = true;
        openFirewall = true;
      };
    };

    users.groups.${services.transmission.group}.members = [
      services.jellyfin.group
      services.shoko.group
      services.sonarr.group
    ];
  };
}
