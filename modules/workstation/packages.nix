{
  pkgs,
  lib',
  config,
  flakePkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  user.packages = with pkgs; let
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
}
