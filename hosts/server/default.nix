{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "diniamo-SERVER";

  services = {
    satisfactory.enable = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
