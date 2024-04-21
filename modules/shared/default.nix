{
  imports = [
    # inputs.nur.nixosModules.nur

    ./overlays
    ./options

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./no-home-manager.nix
  ];
}
