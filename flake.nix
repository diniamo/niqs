{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    stable.url = "nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs is only used for tests, so no don't need to follow it here
    wrapper-manager.url = "github:viperML/wrapper-manager";

    # These are downloaded from caches, so overriding nixpkgs would break them
    hyprland.url = "github:hyprwm/Hyprland";
    anyrun.url = "github:Kirottu/anyrun";
    nix-gaming.url = "github:fufexan/nix-gaming";

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
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib' = import ./lib {inherit inputs;};
  in {
    nixosConfigurations = import ./hosts {inherit inputs lib';};
  };
}
