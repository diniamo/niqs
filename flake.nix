{
  description = "My NixOS flake configuration";

  outputs = inputs: let
    lib' = import ./lib {inherit inputs lib';};
  in {
    nixosConfigurations = import ./hosts {inherit lib';};
  };

  inputs = {
    # Using Hyprland's nixpkgs input
    # - avoids mesa version mismatches
    # - avoids a lot of duplicate packages due to different versions
    nixpkgs.follows = "hyprland/nixpkgs";
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:diniamo/nixpkgs/custom";

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:diniamo/home-manager/custom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # These are downloaded from caches, so overriding nixpkgs would break them
    niqspkgs = {
      url = "github:diniamo/niqspkgs";
      inputs = {
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        lix.inputs.flake-compat.follows = "flake-compat";
      };
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.systems.follows = "systems";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.flake-parts.follows = "flake-parts";
    };

    jerry = {
      url = "github:justchokingaround/jerry";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };
    lobster = {
      url = "github:justchokingaround/lobster";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bgar = {
      url = "github:diniamo/bgar";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
        crane.follows = "crane";
        rust-overlay.follows = "rust-overlay";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.naersk.follows = "naersk";
    };
    stylix = {
      # url = "github:danth/stylix";
      url = "github:diniamo/stylix/custom";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";
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
    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-utils.follows = "flake-utils";
        flake-parts.follows = "flake-parts";

        zig.inputs = {
          flake-utils.follows = "flake-utils";
          flake-compat.follows = "flake-compat";
          nixpkgs.follows = "nixpkgs";
        };
        rnix-lsp.inputs = {
          naersk.follows = "naersk";
          utils.follows = "flake-utils";
          nixpkgs.follows = "nixpkgs";
        };
        nil.inputs = {
          # This should already be followed, nix is tripping
          nixpkgs.follows = "nixpkgs";

          rust-overlay.follows = "rust-overlay";
          flake-utils.follows = "flake-utils";
        };
      };
    };

    wallpapers = {
      url = "github:diniamo/wallpapers";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [
      # Use this first
      "https://cache.nixos.org?priority=10"
      "https://cache.garnix.io"
      "https://numtide.cachix.org"

      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="

      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };
}
