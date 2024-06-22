{inputs}: let
  inherit (inputs.nixpkgs) lib;

  getPkgs = input: system:
    if (input.legacyPackages.${system} or {}) == {}
    then input.packages.${system}
    else input.legacyPackages.${system};

  # Builders
  mkNixosSystem = args @ {
    system,
    modules,
    ...
  }: let
    # pkgs = inputs.nixpkgs.legacyPackages.${system};
    # Since this is outside of the main module system, we have to set allowUnfree here too
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    flakePkgs = builtins.mapAttrs (_: value: getPkgs value system) inputs;
    customPkgs = import ../packages {inherit pkgs;};
    wrappedPkgs = import ../wrappers {inherit inputs pkgs;};
  in
    lib.nixosSystem {
      inherit system modules;
      specialArgs = {inherit inputs system flakePkgs customPkgs wrappedPkgs;} // args.specialArgs or {};
    };

  # Helpers
  nameToSlug = name: lib.toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
  overrideError = pkg: version: value: lib.throwIf (lib.versionOlder version pkg.version) "A new version of ${pkg.pname} has been released, remove its overlay/override" value;

  pow = base: exponent:
    if exponent == 0
    then 1
    else if exponent == 1
    then base
    else base * (pow base (exponent - 1));
  shiftLeft = number: amount: number * (pow 2 amount);
in {
  inherit mkNixosSystem nameToSlug boolToNum overrideError shiftLeft;
}
