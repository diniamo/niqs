{
  description = "My NixOS flake configuration";

  outputs = inputs: let
    lib' = import ./lib {inherit inputs lib';};
  in {
    nixosConfigurations = import ./hosts {inherit lib';};
  };

  nixConfig = {
    extra-substituters = [
      # Use this first
      "https://cache.nixos.org?priority=10"
      "https://niqspkgs.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niqspkgs.cachix.org-1:3lcNxXkj8BLrK77NK9ZTjk0fxHuSZrr5sKE6Avjb6PI="
    ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:diniamo/nixpkgs/custom";
    # nixpkgs.url = "path:/hdd/dev/nixpkgs";

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:diniamo/home-manager/custom";
      inputs.nixpkgs.follows = "nixpkgs";
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
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
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

    # These are downloaded from caches, so overriding nixpkgs would break them
    niqspkgs = {
      url = "github:diniamo/niqspkgs";
      inputs = {
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        lix.inputs.flake-compat.follows = "flake-compat";
        lix.inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };

    curd = {
      url = "github:Wraient/curd";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    lobster = {
      url = "github:justchokingaround/lobster";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        crane.follows = "crane";
        rust-overlay.follows = "rust-overlay";
        pre-commit-hooks-nix.inputs.gitignore.follows = "gitignore";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        git-hooks.follows = "pre-commit-hooks";
        nur.inputs.flake-parts.follows = "flake-parts";
      };
    };
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";

        searx-randomizer.inputs = {
          crane.follows = "crane";
          flake-parts.follows = "flake-parts";
          nixpkgs.follows = "nixpkgs";
        };
      };
    };
    wayhibitor = {
      url = "github:diniamo/wayhibitor";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

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
