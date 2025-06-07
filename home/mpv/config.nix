{config, ...}: let
  font = config.stylix.fonts.sansSerif.name;
in {
  programs.mpv = {
    config = {
      fullscreen = true;
      no-keepaspect-window = "";
      save-position-on-quit = "";
      watch-later-options-remove = "vf,af";
      no-window-dragging = "";
      osc = false;
      osd-font = font;
      osd-duration = 3000;
      osd-status-msg = "Frame: \${estimated-frame-number} / \${estimated-frame-count}";
      audio-device = "pipewire";
      volume-max = 100;

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "format-sort=\"proto:m3u8\",mark-watched=,cookies-from-browser=\"firefox\",user-agent=\"Mozilla/5.0\"";

      alang = "ja,de,en,hu";
      slang = "de,en,hu";
      sub-visibility = "no";
    };

    defaultProfiles = ["high-quality"];

    scriptOpts = {
      modernx = {
        inherit font;
        window_title = false;
        window_controls = false;
        show_on_pause = false;
        volume_control_type = "logarithmic";
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
