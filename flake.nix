{
  description = "My NixOS flake configuration";

  outputs = inputs: let
    lib' = import ./lib { inherit inputs lib'; };
  in {
    nixosConfigurations = import ./hosts lib';
  };

  nixConfig = {
    extra-substituters = [ "https://niqspkgs.cachix.org?priority=41" ];
    extra-trusted-public-keys = [ "niqspkgs.cachix.org-1:3lcNxXkj8BLrK77NK9ZTjk0fxHuSZrr5sKE6Avjb6PI=" ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:diniamo/nixpkgs/custom";

    nix-home = {
      url = "github:diniamo/nix-home";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    # Mostly transitive inputs for deduplication
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-compat.url = "github:edolstra/flake-compat";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitignore.url = "github:hercules-ci/gitignore.nix";
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        gitignore.follows = "gitignore";
      };
    };

    # Nixpkgs isn't overridden here for correctness, but I keep the base commit
    # the same, so there won't be any duplicate packages.
    niqspkgs = {
      url = "github:diniamo/niqspkgs";
      inputs = {
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        dnix.inputs.git-hooks-nix.inputs.flake-compat.follows = "flake-compat";
        unified-inhibit.inputs.flake-utils.follows = "flake-utils";
      };
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
        pre-commit.follows = "pre-commit-hooks";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    watt.follows = "niqspkgs/watt";

    wallpapers = {
      url = "github:diniamo/wallpapers";
      flake = false;
    };
    artcnn = {
      url = "github:Artoriuz/ArtCNN";
      flake = false;
    };
    dwl = {
      url = "github:diniamo/dwl";
      flake = false;
    };
  };
}
