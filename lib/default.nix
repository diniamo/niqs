{ inputs, lib' }: let
  inherit (inputs.nixpkgs) lib;

  importPart = path: import path { inherit inputs lib lib'; };

  builders = importPart ./builders.nix;
  generators = importPart ./generators.nix;
in builders // generators
