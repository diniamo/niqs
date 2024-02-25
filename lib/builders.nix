{
  inputs,
  lib,
  ...
}: let
  inherit (lib) nixosSystem;
  inherit (import ./mappers.nix) inputsToPackages;

  mkNixosSystem = args @ {
    system,
    modules,
    ...
  }: let
    packages = inputsToPackages inputs system;
  in
    nixosSystem {
      inherit system modules;
      # We can't pass lib because that's from nixpkgs, and we need the extended version
      specialArgs = {inherit inputs system packages;} // args.specialArgs or {};
    };
in {
  inherit mkNixosSystem;
}
