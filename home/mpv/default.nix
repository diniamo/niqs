{
  pkgs,
  flakePkgs,
  ...
}: let
  scripts = with pkgs.mpvScripts;
  with flakePkgs.niqspkgs.mpvScripts; [
    # Missing: clipshot, autosubsync
    uosc
    reload
    thumbfast
    mpris
    mpv-webm
    seekTo
    sponsorblock-minimal

    SimpleUndo
    skiptosilence
  ];
in {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
    ./uosc.nix
    ./anime.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {vapoursynthSupport = true;}) {
      inherit scripts;
      youtubeSupport = true;
    };
  };
}
