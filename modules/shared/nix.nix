{
  inputs,
  flakePkgs,
  lib,
  ...
}: let
  # The unfree version breaks repl/devshells that rely on `import <nixpkgs> {}`
  # but we still want to use it for the default flake, which may be used for nix3 shells, builds, and runs
  inherit (inputs) nixpkgs;
  nixpkgsUpstream = inputs.nixpkgs-upstream;
  upstreamPath = nixpkgsUpstream.outPath;
in {
  nix = {
    package = flakePkgs.niqspkgs.lix-default-flake;

    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];

      auto-optimise-store = true;
      builders-use-substitutes = true;

      experimental-features = ["nix-command" "flakes"];
      default-flake = nixpkgs;
      log-lines = 30;
      http-connections = 50;
    };

    registry = {
      nixpkgs.flake = lib.mkForce nixpkgsUpstream;
      n.flake = nixpkgsUpstream;
    };
    nixPath = [
      "nixpkgs=${upstreamPath}"
      "n=${upstreamPath}"
    ];
  };
}
