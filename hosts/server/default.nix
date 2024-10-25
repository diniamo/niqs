{
  imports = [./hardware.nix];

  networking.hostName = "diniamo-SERVER";

  services.satisfactory.enable = true;

  custom = {
    torrent.enable = true;
    media.enable = true;
    monitoring.enable = true;
  };

  system.stateVersion = "23.11";
}
