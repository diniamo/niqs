{inputs}: let
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
      inherit system;
      specialArgs = {inherit inputs system flakePkgs wrappedPkgs;} // args.specialArgs or {};
      # For some reason, the source set by nixosSystem does not have the options set by nixpkgs-unfree
      # so we set pkgs instead
      modules =
        [
          {nixpkgs.pkgs = pkgs;}
        ]
        ++ args.modules or [];
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
