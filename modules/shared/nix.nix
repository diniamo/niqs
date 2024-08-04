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
      accept-flake-config = true;
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];

      auto-optimise-store = true;
      builders-use-substitutes = true;

      experimental-features = ["nix-command" "flakes"];
      default-flake = nixpkgs;
      log-lines = 30;
      http-connections = 50;
    };

    registry = {
      nixpkgs.flake = nixpkgs;
      n.flake = nixpkgs;
      default.flake = nixpkgs;
    };
    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "n=${nixpkgsPath}"
      "default=${nixpkgsPath}"
    ];
  };
}
