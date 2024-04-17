{inputs, ...}: {
  imports = [
    # inputs.nur.nixosModules.nur
    inputs.chaotic.nixosModules.default

    ./overlays
    ./options

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./no-home-manager.nix
  ];
}
