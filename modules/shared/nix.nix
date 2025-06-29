{ inputs, pkgs, ... }: let
  inherit (inputs) nixpkgs;
in {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
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
      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      log-lines = 25;
      http-connections = 50;
      allow-import-from-derivation = false;
    };

    registry = {
      nixpkgs.flake = nixpkgs;
      n.flake = nixpkgs;
    };

    channel.enable = false;
    nixPath = [
      "nixpkgs=${nixpkgs}"
      "n=${nixpkgs}"
    ];
  };
}
