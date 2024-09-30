{lib'}: let
  inherit (lib') mkNixosSystem;

  modulePath = ../modules;

  shared = modulePath + /shared;
  workstation = modulePath + /workstation;
  server = modulePath + /server;
in {
  desktop = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./desktop
      shared
      workstation
    ];
  };

  server = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./server
      shared
      server
    ];
  };

  laptop = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./laptop
      shared
      workstation
    ];
  };
}
