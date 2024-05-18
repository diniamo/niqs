{inputs}: let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) nixosSystem throwIf versionOlder;
  inherit (lib.strings) toLower;

  # Other
  getPkgs = input: system:
    if (input.legacyPackages.${system} or {}) == {}
    then input.packages.${system}
    else input.legacyPackages.${system};
  inputsToPackages = inputs: system: builtins.mapAttrs (_: value: getPkgs value system) inputs;

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

    flakePkgs = inputsToPackages inputs system;
    customPkgs = import ../packages {inherit pkgs;};
    wrappedPkgs = import ../wrappers {inherit inputs pkgs;};
  in
    nixosSystem {
      inherit system modules;
      specialArgs = {inherit inputs system flakePkgs customPkgs wrappedPkgs;} // args.specialArgs or {};
    };

  # Helpers
  nameToSlug = name: toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
  overrideError = pkg: version: value: throwIf (versionOlder version pkg.version) "A new version of ${pkg.pname} has been released, remove its overlay/override" value;
  versionOverride = pkg: version: overrideError pkg version (pkg.overrideAttrs {inherit version;});
in
  # lib.extend (_: _: foldl recursiveUpdate {} importedLibs)
  # foldl recursiveUpdate {} importedLibs
  {
    inherit mkNixosSystem nameToSlug boolToNum overrideError versionOverride;
  }
