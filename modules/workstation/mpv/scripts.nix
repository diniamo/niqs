{ pkgs, flakePkgs, config, ... }: {
  custom.mpv = {
    scripts = with pkgs.mpvScripts; with flakePkgs.niqspkgs; [
      thumbfast
      modernx-zydezu
        
      reload
      mpris
      seekTo
      sponsorblock-minimal
      skip-to-silence
      m-x
    ];

    scriptOpts = {
      modernx = {
        font = config.custom.style.fonts.regular.name;
        window_title = false;
        window_controls = false;
        show_on_pause = false;
        info_button = true;
        ontop_button = false;
        download_path = "/tmp";
        hover_effect = "size";
      };

      skiptosilence = {
        duration = 0.5;
        mutewhileskipping = true;
      };
    };
  };
}
