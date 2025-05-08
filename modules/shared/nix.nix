{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) nixpkgs;
  nixpkgsPath = nixpkgs.outPath;
in {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operator"];
      # This only sets the embedded flake registry, which we don't want
      flake-registry = pkgs.writeText "minimal-flake-registry.json" ''
        {
          "version": 2,
          "flakes": []
        }
      '';
      default-flake = nixpkgs;
      accept-flake-config = true;
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      log-lines = 30;
      http-connections = 50;
    };

    registry = {
      nixpkgs.flake = nixpkgs;
      n.flake = nixpkgs;
      default.flake = nixpkgs;
    };

    channel.enable = false;
    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "n=${nixpkgsPath}"
      "default=${nixpkgsPath}"
    ];
  };
}
