{ lib, lib', inputs, ... }: let
  inherit (lib) nixosSystem escapeShellArgs;
  inherit (builtins) mapAttrs;
in {
  nixosSystem' = { system, ... }@args: nixosSystem {
    system = null;

    # Infinite recursion if I don't put this here
    specialArgs = { inherit inputs; };

    modules = [{
      _module.args = {
        inherit system lib';
        flakePkgs = mapAttrs (_: input: input.legacyPackages.${system} or {} // input.packages.${system} or {}) inputs;
      };

      nixpkgs = {
        inherit system;
        config.allowUnfree = true;
      };
    }] ++ args.modules or [];
  };
}
