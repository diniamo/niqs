{
  pkgs,
  lib',
  config,
  flakePkgs,
  ...
}: let
  inherit (config.values) mainUser;

  fish = config.home-manager.users.${mainUser}.programs.fish.package;
in {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs = {
    command-not-found.enable = false;
    fish = {
      enable = true;
      package = fish;
    };
  };
  
  users.users.${mainUser}.shell = fish;

  # For electron apps
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; let
      wrapProgram = args: lib'.wrapProgram ({
        inherit symlinkJoin;
        wrapper = makeBinaryWrapper;
      } // args);
    in with flakePkgs.niqspkgs; [
      (wrapProgram { wrapperArgs = ["--add-flags" "--all --and-exit"]; } xdragon)

      wl-clipboard
      spotify
      gtrash
      libqalculate
      wiremix
      pwvucontrol
      eza
      libnotify
      gist
      video-trimmer
      flint
      dsync
    ];
  };
}
