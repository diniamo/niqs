lib': let
  inherit (lib') nixosSystem';

  modulePath = ../modules;

  shared = modulePath + /shared;
  workstation = modulePath + /workstation;
  server = modulePath + /server;
in {
  desktop = nixosSystem' {
    system = "x86_64-linux";
    modules = [
      ./desktop
      shared
      workstation
    ];
  };

  server = nixosSystem' {
    system = "x86_64-linux";
    modules = [
      ./server
      shared
      server
    ];
  };

  laptop = nixosSystem' {
    system = "x86_64-linux";
    modules = [
      ./laptop
      shared
      workstation
    ];
  };
}
