{
  description = "My NixOS flake configuration";

  outputs = inputs: let
    lib' = import ./lib { inherit inputs lib'; };
  in {
    nixosConfigurations = import ./hosts lib';
  };

  nixConfig = {
    extra-substituters = [
      # Lower priorities are tried first
      # The default priority (NixOS cache) is 40
      "https://niqspkgs.cachix.org?priority=41"
      "https://nix-community.cachix.org?priority=42" # CUDA
    ];
    extra-trusted-public-keys = [
      "niqspkgs.cachix.org-1:3lcNxXkj8BLrK77NK9ZTjk0fxHuSZrr5sKE6Avjb6PI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:diniamo/nixpkgs/custom";
    # nixpkgs.url = "path:/hdd/dev/nixpkgs";

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
      };
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        rust-overlay.follows = "rust-overlay";
        pre-commit-hooks-nix.inputs.gitignore.follows = "gitignore";
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

    tree-sitter-odin = {
      url = "github:tree-sitter-grammars/tree-sitter-odin";
      flake = false;
    };
    odin-ts-mode = {
      url = "github:Sampie159/odin-ts-mode";
      flake = false;
    };
  };
}
