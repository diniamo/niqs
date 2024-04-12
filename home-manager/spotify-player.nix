{
  programs.spotify-player = {
    enable = true;

    settings = {
      copy_command.command = "wl-copy";
      page_size_in_rows = 30;
      border_type = "Rounded";
      device = {
        volume = 100;
        device_type = "computer";
        audio_cache = true;
        normalization = true;
      };
    };

    keymaps = [
      {
        key_sequence = "q";
        command = "Quit";
      }
      {
        key_sequence = "í";
        command = "PreviousTrack";
      }
      {
        key_sequence = "y";
        command = "NextTrack";
      }
      {
        key_sequence = "left";
        command = "SeekBackward";
      }
      {
        key_sequence = "right";
        command = "SeekForward";
      }
    ];
  };
}
