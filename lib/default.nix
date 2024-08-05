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

  wrapProgram = pkgs: package: args:
    package.overrideAttrs (prev: {
      # HACK: has to be added first, since if the program relies on the Bash wrapper's variable expansion, it breaks with the binary wrapper
      # sourcing makeBinaryWrapper's setup hook fails with some random error
      # is there a better way?
      nativeBuildInputs = [pkgs.makeBinaryWrapper] ++ prev.nativeBuildInputs or [];
      postPhases = (prev.postPhases or []) ++ ["wrapPhase"];
      wrapPhase = "wrapProgram $(realpath $out/bin/${args.executable or prev.meta.mainProgram}) ${lib.escapeShellArgs args.makeWrapperArgs}";
    });

  # Helpers
  overrideError = pkg: version: value: lib.throwIf (lib.versionOlder version pkg.version) "A new version of ${pkg.pname} has been released, remove its overlay/override" value;

  pow = base: exponent:
    if exponent == 0
    then 1
    else if exponent == 1
    then base
    else base * (pow base (exponent - 1));
  shiftLeft = number: amount: number * (pow 2 amount);

  mapToAttrs = func: list: builtins.listToAttrs (map func list);
in {
  inherit mkNixosSystem wrapProgram overrideError shiftLeft mapToAttrs;
}
