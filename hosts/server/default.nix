{
  imports = [./hardware.nix];

  networking = {
    hostName = "diniamo-SERVER";

    dhcpcd.enable = false;
    interfaces.enp10s0.ipv4.addresses = [
      {
        address = "192.168.0.120";
        prefixLength = 24;
      }
    ];
    defaultGateway = {
      interface = "enp10s0";
      address = "192.168.0.1";
    };
  };

  services.satisfactory.enable = true;

  custom = {
    torrent.enable = true;
    media.enable = true;
    monitoring.enable = true;
  };

  system.stateVersion = "23.11";
}
