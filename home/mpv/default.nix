{
  pkgs,
  flakePkgs,
  ...
}: let
  scripts = with pkgs.mpvScripts;
  with flakePkgs.niqspkgs; [
    # Missing: clipshot, autosubsync
    uosc
    reload
    thumbfast
    mpris
    mpv-webm
    seekTo
    sponsorblock-minimal
    autoload

    simple-undo
    skip-to-silence
  ];
in {
  imports = [
    ./config.nix
    ./input.nix
    ./profiles.nix
    ./uosc.nix
    ./anime.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      inherit scripts;
      youtubeSupport = true;
    };
  };
}
