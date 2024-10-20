{pkgs, ...}: {
  imports = [./hardware.nix];

  networking.hostName = "diniamo-SERVER";

  services = {
    satisfactory.enable = true;

    transmission = {
      enable = true;

      openRPCPort = true;
      webHome = pkgs.flood-for-transmission;
      credentialsFile = "/var/lib/transmission/settings.json";
      downloadDirPermissions = "755";

      settings = {
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist-enabled = false;
        anti-brute-force-enabled = true;
        rpc-authentication-required = true;

        rename-partial-files = false;
        incomplete-dir-enabled = true;
      };
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    shokoserver = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };

  systemd.services.transmission.serviceConfig.StateDirectoryMode = 755;

  system.stateVersion = "23.11";
}
