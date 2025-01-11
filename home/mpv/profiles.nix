{
  programs.mpv.profiles = {
    best = {
      profile = "high-quality";
      video-sync = "display-resample";
      interpolation = "";
      tscale = "oversample";
    };

    svp = {
      input-ipc-server = "/tmp/mpvsocket";
      hr-seek-framedrop = false;
      # watch-later-options-remove = "vf";
    };
  };
}
