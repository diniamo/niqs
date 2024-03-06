{inputs}: let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) recursiveUpdate foldl;

  # TODO: Attempt to pass this module instead of lib
  builders = import ./builders.nix {inherit inputs lib;};
  mappers = import ./mappers.nix;
  helpers = import ./helpers.nix {inherit lib;};

  importedLibs = [builders mappers helpers];
in
  # lib.extend (_: _: foldl recursiveUpdate {} importedLibs)
  foldl recursiveUpdate {} importedLibs
