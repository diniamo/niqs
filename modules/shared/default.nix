{inputs, ...}: {
  imports = [
    # inputs.nur.nixosModules.nur
    inputs.chaotic.nixosModules.default

    ./overlays

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./environment.nix
    ./values.nix
  ];
}
