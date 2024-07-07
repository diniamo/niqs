{
  inputs,
  flakePkgs,
  ...
}: let
  inherit (inputs) nixpkgs;
  nixpkgsPath = nixpkgs.outPath;
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
      nixpkgs.flake = nixpkgs;
      n.flake = nixpkgs;
    };

    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "n=${nixpkgsPath}"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
