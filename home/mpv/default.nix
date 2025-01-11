{
  pkgs,
  flakePkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./input.nix
    ./profiles.nix
    ./uosc.nix
    ./anime.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg-headless;

        alsaSupport = false;
        javascriptSupport = false;
        pulseSupport = false;
        x11Support = false;
      };

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
        mpvacious

        simple-undo
        skip-to-silence
      ];
    };
  };
}
