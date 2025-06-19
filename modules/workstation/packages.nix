{ pkgs, lib', flakePkgs, ... }: let
  inherit (lib') wrapProgram;
in {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  user.packages = with pkgs; with flakePkgs.niqspkgs; [
    (wrapProgram pkgs { package = xdragon; args = [ "--add-flags" "--all --and-exit" ]; })

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
    file
    git
  ];
}
