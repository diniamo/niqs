{
  inputs,
  lib',
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;

  getPkgs = input: system:
    if (input.legacyPackages.${system} or {}) == {}
    then input.packages.${system}
    else input.legacyPackages.${system};

  # Builders
  mkNixosSystem = args @ {system, ...}: let
    pkgs = nixpkgs.legacyPackages.${system};

    flakePkgs = builtins.mapAttrs (_: value: getPkgs value system) inputs;
    wrappedPkgs = import ../wrappers {inherit inputs pkgs;};
  in
    lib.nixosSystem {
      system = null;

      # Infinite recursion if I don't put this here
      specialArgs = {inherit inputs;};

      modules =
        (args.modules or [])
        ++ [
          {
            _module.args = {inherit lib' system flakePkgs wrappedPkgs;};

            # For some reason, the source set by nixosSystem does not have the options set by nixpkgs-unfree
            # so we set pkgs instead
            nixpkgs.pkgs = pkgs;
          }
        ];
    };

  # Helpers
  overrideError = pkg: version: value: lib.throwIf (lib.versionOlder version pkg.version) "A new version of ${pkg.pname} has been released, remove its overlay/override" value;

  pow = base: exponent:
    if exponent == 0
    then 1
    else if exponent == 1
    then base
    else base * (pow base (exponent - 1));
  shiftLeft = number: amount: number * (pow 2 amount);
in {
  inherit mkNixosSystem overrideError shiftLeft;
}
