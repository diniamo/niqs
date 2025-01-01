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

  inputs = {
    # Using Hyprland's nixpkgs input
    # - avoids mesa and qt version mismatches
    # - avoids a lot of duplicate packages due to different versions
    # nixpkgs.follows = "hyprland/nixpkgs";
    # nixpkgs.url = "nixpkgs/nixos-unstable";
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
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        systems.follows = "systems";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
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
    wallpapers = {
      url = "github:diniamo/wallpapers";
      flake = false;
    };

    nvf = {
      # url = "github:NotAShelf/nvf";
      url = "github:diniamo/nvf/custom";
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
    bufresize-nvim = {
      url = "github:kwkarlwang/bufresize.nvim";
      flake = false;
    };
    direnv-nvim = {
      url = "github:diniamo/direnv.nvim";
      flake = false;
    };
    fastaction-nvim = {
      url = "github:Chaitanyabsprip/fastaction.nvim";
      flake = false;
    };
    harpoon = {
      url = "github:ThePrimeagen/harpoon/harpoon2";
      flake = false;
    };
    cmp-nvim-lua = {
      url = "github:hrsh7th/cmp-nvim-lua";
      flake = false;
    };
    feline-nvim = {
      url = "github:freddiehaddad/feline.nvim";
      flake = false;
    };
    oil-nvim = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };
    nvim-lastplace = {
      url = "github:ethanholz/nvim-lastplace";
      flake = false;
    };
    telescope-zf-native-nvim = {
      url = "github:natecraddock/telescope-zf-native.nvim";
      flake = false;
    };
    telescope-zoxide = {
      url = "github:jvgrootveld/telescope-zoxide";
      flake = false;
    };
    flit-nvim = {
      url = "github:ggandor/flit.nvim";
      flake = false;
    };
    no-neck-pain-nvim = {
      url = "github:shortcuts/no-neck-pain.nvim";
      flake = false;
    };
  };
}
