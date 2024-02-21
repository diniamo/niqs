{ inputs, ... }: {
  imports = [
    inputs.nur.nixosModules.nur

    ../../options

    ./system.nix
    ./boot.nix
  ];
}
