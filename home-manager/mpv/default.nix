{pkgs, ...}: let
  scripts = with pkgs.mpvScripts; [
    # Missing: UndoRedo, skip-intro, clipshot, autosubsync
    uosc
    reload
    thumbfast
    mpris
    mpv-webm
    seekTo
    sponsorblock-minimal
  ];
in {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {vapoursynthSupport = true;}) {
      inherit scripts;
      youtubeSupport = true;
    };

    scriptOpts = {
      uosc = import ./uosc.nix;
    };
  };
}
