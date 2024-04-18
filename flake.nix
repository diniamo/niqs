{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nur.url = "github:nix-community/nur";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niqspkgs = {
      url = "github:diniamo/niqspkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:diniamo/home-manager/add-spotify-player";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs is only used for tests, so no need to follow it here
    wrapper-manager.url = "github:viperML/wrapper-manager";

    # These are downloaded from caches, so overriding nixpkgs would break them
    hyprland.url = "github:hyprwm/Hyprland";
    anyrun.url = "github:Kirottu/anyrun";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-super.url = "github:privatevoid-net/nix-super";

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jerry = {
      url = "github:justchokingaround/jerry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lobster = {
      url = "github:justchokingaround/lobster";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    no_decorations_when_only = {
      url = "github:diniamo/no_decorations_when_only";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bgar = {
      url = "github:diniamo/bgar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib' = import ./lib {inherit inputs;};
  in {
    nixosConfigurations = import ./hosts {inherit lib';};
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://cache.privatevoid.net"
      "https://nix-gaming.cachix.org"
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
}
