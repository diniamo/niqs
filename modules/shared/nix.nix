{
  inputs,
  flakePkgs,
  ...
}: let
  inherit (inputs) nixpkgs;
  nixpkgsPath = nixpkgs.outPath;
in {
  nix = {
    package = flakePkgs.nix-super.default;

    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];

      auto-optimise-store = true;
      builders-use-substitutes = true;

      experimental-features = ["nix-command" "flakes"];
      log-lines = 30;
      http-connections = 50;
    };

    registry = {
      nixpkgs.flake = nixpkgs;
      default.flake = nixpkgs;
    };

    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "default=${nixpkgsPath}"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
