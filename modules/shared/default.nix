{inputs, ...}: {
  imports = [
    inputs.nur.nixosModules.nur

    ../../options

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./cachix.nix
    ./environment.nix
  ];
}
