{
  inputs,
  lib',
}: let
  inherit (inputs.nixpkgs) lib;

  getPkgs = input: system:
    if (input.legacyPackages.${system} or {}) == {}
    then input.packages.${system}
    else input.legacyPackages.${system};

  # Builders
  mkNixosSystem = args @ {system, ...}:
    lib.nixosSystem {
      system = null;

      # Infinite recursion if I don't put this here
      specialArgs = {inherit inputs;};

      modules =
        [
          {
            _module.args = {
              inherit system lib';
              flakePkgs = builtins.mapAttrs (_: value: getPkgs value system) inputs;
            };

            nixpkgs = {
              inherit system;
              config.allowUnfree = true;
            };
          }
        ]
        ++ args.modules or [];
    };

  wrapProgram = {
    pkgs,
    package,
    binaryWrapper ? true,
    wrapperArgs,
  } @ args: let
    package' =
      if builtins.isString package
      then pkgs.${package}
      else package;

    wrapper =
      if binaryWrapper
      then pkgs.makeBinaryWrapper
      else pkgs.makeWrapper;

    file = args.executable or package'.meta.mainProgram;
  in
    pkgs.symlinkJoin {
      name = "${package'.pname}-wrapped";
      paths = [package'];

      nativeBuildInputs = [wrapper];
      postBuild = "wrapProgram $out/bin/${file} ${lib.escapeShellArgs wrapperArgs}";
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

  mapListToAttrs = func: list: builtins.listToAttrs (map func list);
in {
  inherit mkNixosSystem wrapProgram overrideError shiftLeft mapListToAttrs;
}
