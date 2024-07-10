{
  description = "My NixOS flake configuration";

  inputs = {
    # Might want to make everything follow this instead
    # nixpkgs-upstream.url = "nixpkgs/nixos-unstable";
    nixpkgs-upstream.url = "github:diniamo/nixpkgs/custom";
    nixpkgs.url = "github:numtide/nixpkgs-unfree/nixos-unstable";
    nixpkgs.inputs.nixpkgs.follows = "nixpkgs-upstream";

    home-manager = {
      url = "github:nix-community/home-manager";
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
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.systems.follows = "systems";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
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
        # Imoprts nixpkgs, which nixpkgs-unfree doesn't allow
        nixpkgs.follows = "nixpkgs-upstream";
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

    base16-fish = {
      url = "github:diniamo/base16-fish/tmp";
      flake = false;
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";

        base16-fish.follows = "base16-fish";
      };
    };

    searx-randomizer = {
      url = "github:schizofox/searx-randomizer";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        crane.follows = "crane";
      };
    };
    schizofox = {
      # url = "github:schizofox/schizofox";
      url = "github:diniamo/schizofox/filter-null-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";

        searx-randomizer.follows = "searx-randomizer";
      };
    };

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.utils.follows = "flake-utils";
      inputs.naersk.follows = "naersk";
    };
    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "rust-overlay";
      };
    };
    nvf = {
      # url = "github:notashelf/nvf";
      url = "github:diniamo/nvf/hm-merge-lists";
      # url = "path:/hdd/dev/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-utils.follows = "flake-utils";
        flake-parts.follows = "flake-parts";

        zig.follows = "zig";
        rnix-lsp.follows = "rnix-lsp";
        nil.follows = "nil";
      };
    };
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.naersk.follows = "naersk";
    };
  };

  outputs = inputs: let
    lib' = import ./lib {inherit inputs;};
  in {
    nixosConfigurations = import ./hosts {inherit lib';};
  };

  nixConfig = {
    extra-substituters = [
      # Use this first
      "https://cache.nixos.org?priority=10"
      "https://numtide.cachix.org"

      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
      "https://nix-gaming.cachix.org"
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="

      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
}
