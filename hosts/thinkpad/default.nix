{ config, ... }:

{
  imports = [ ./hardware.nix ];

  networking.hostName = "${config.values.mainUser}-THINKPAD";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}

