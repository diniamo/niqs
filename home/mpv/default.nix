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

    simple-undo
    skip-to-silence
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
    package = pkgs.wrapMpv pkgs.mpv-unwrapped {
      inherit scripts;
      youtubeSupport = true;
    };
  };
}
