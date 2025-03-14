{
  programs.mpv = {
    config = {
      fullscreen = true;
      no-keepaspect-window = "";
      save-position-on-quit = "";
      watch-later-options-remove = "vf,af";
      no-window-dragging = "";
      osd-duration = 3000;
      osd-status-msg = "Frame: \${estimated-frame-number} / \${estimated-frame-count}";
      audio-device = "pipewire";
      volume-max = 100;

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "format-sort=\"proto:m3u8\",mark-watched=,cookies-from-browser=\"firefox\",user-agent=\"Mozilla/5.0\"";

      alang = "ja,de,en,hu";
      slang = "de,en,hu";
      no-sub-visibility = "";
    };

    defaultProfiles = ["high-quality"];

    scriptOpts = {
      skiptosilence = {
        duration = 0.5;
        mutewhileskipping = true;
      };

      autoload.same_type = true;
    };
  };
}
