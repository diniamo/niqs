{lib'}: let
  inherit (lib') mkNixosSystem;

  modulePath = ../modules;

  shared = modulePath + /shared;
  workstation = modulePath + /workstation;
  server = modulePath + /server;

  # This has to be passed here, and not in the builder, so it's the extended version
  specialArgs = {inherit lib';};
in {
  desktop = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./desktop
      shared
      workstation
    ];
    inherit specialArgs;
  };
  server = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./server
      shared
      server
    ];
    inherit specialArgs;
  };
  thinkpad = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      ./thinkpad
      shared
      workstation
    ];
    inherit specialArgs;
  };
}
