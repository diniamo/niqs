{
  config,
  inputs,
  lib,
  pkgs,
  flakePkgs,
  ...
}: let
  inherit (lib) mkDefault;

  nixpkgsPath = inputs.nixpkgs.outPath;
in {
  nix = {
    package = flakePkgs.nix-super.default;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
      log-lines = 30;
      http-connections = 50;

      accept-flake-config = true;
      trusted-users = ["@wheel"];
    };

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      default.flake = inputs.nixpkgs;
    };

    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "default=${nixpkgsPath}"
    ];
  };

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "hu";
  };

  boot = {
    tmp.useTmpfs = mkDefault true;
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
