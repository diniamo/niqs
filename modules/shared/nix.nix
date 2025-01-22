{
  inputs,
  pkgs,
  ...
}: let
  # The unfree version breaks repl/devshells that rely on `import <nixpkgs> {}`
  # but we still want to use it for the default flake, which may be used for nix3 shells, builds, and runs
  # At least that used to be the case, but using nixpkgs-unfree comes with disadvantages, such as not being able to set config options yourself
  # TODO: is there a solution without using it?
  inherit (inputs) nixpkgs;
  nixpkgsPath = nixpkgs.outPath;
in {
  nix = {
    package = pkgs.lix;

    settings = {
      experimental-features = ["nix-command" "flakes"];
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
