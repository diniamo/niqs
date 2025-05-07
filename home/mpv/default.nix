{
  pkgs,
  flakePkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./input.nix
    ./anime.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg-headless;

        alsaSupport = false;
        javascriptSupport = false;
        pulseSupport = true; # For laptop, cba modularizing
        x11Support = false;
      };

      scripts = with pkgs.mpvScripts; with flakePkgs.niqspkgs; [
        modernx-zydezu
        thumbfast
        
        reload
        mpris
        seekTo
        sponsorblock-minimal
        simple-undo
        skip-to-silence
        m-x
      ];
    };
  };
}
