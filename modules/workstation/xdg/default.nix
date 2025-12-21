{ lib, ... }: let
  inherit (lib) mkForce;
in {
  imports = [
    ./dirs.nix
    ./associations.nix
  ];

  xdg = {
    menus.enable = mkForce false;
    autostart.enable = mkForce false;
  };
}
