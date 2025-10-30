{ pkgs, lib, ... }: let
  inherit (lib) getExe';
in {
  custom.spotify-player = {
    enable = true;

    settings = {
      copy_command.command = getExe' pkgs.wl-clipboard "wl-copy";
      page_size_in_rows = 30;
      border_type = "Rounded";
      cover_img_scale = 1.8;

      layout.playback_window_position = "Bottom";

      device = {
        volume = 100;
        device_type = "computer";
      };
    };

    keymaps = [
      { key_sequence = "left";  command.SeekBackward = {}; }
      { key_sequence = "right"; command.SeekForward = {}; }
      { key_sequence = "q";     command = "Quit"; }
      { key_sequence = "í";     command = "PreviousTrack"; }
      { key_sequence = "y";     command = "NextTrack"; }
      { key_sequence = "C-u";   command = "PageSelectPreviousOrScrollUp"; }
      { key_sequence = "C-d";   command = "PageSelectNextOrScrollDown"; }
      { key_sequence = "g e";   command = "SelectLastOrScrollToBottom"; }
      { key_sequence = "G";     command = "None"; }
    ];
  };
}
