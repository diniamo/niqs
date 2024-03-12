{
  pkgs,
  customPkgs,
  ...
}: let
  scripts = with pkgs.mpvScripts;
  with customPkgs.mpvScripts; [
    # Missing: skip-intro, clipshot, autosubsync
    uosc
    reload
    thumbfast
    mpris
    mpv-webm
    seekTo
    sponsorblock-minimal

    SimpleUndo
  ];
in {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
    ./uosc.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {vapoursynthSupport = true;}) {
      inherit scripts;
      youtubeSupport = true;
    };
  };
}
