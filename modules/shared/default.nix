{inputs, ...}: {
  imports = [
    inputs.nur.nixosModules.nur

    ./overlays

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./cachix.nix
    ./environment.nix
    ./values.nix
  ];
}
