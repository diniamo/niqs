{
  programs.mpv = {
    enable = true;
    config = {
      fullscreen = true;
      no-keepaspect-window = "";
      save-position-on-quit = "";
      no-window-dragging = "";

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "format-sort=\"proto:m3u8\",mark-watched=,cookies-from-browser=\"firefox\",user-agent=\"Mozilla/5.0\"";

      audio-device = "pipewire";
    };
    bindings = {
      MBTN_LEFT = "cycle pause";
      # MBTN_RIGHT = "script-binding uosc/menu";
      # menu = "script-binding uosc/menu";

      "0" = "cycle-values playback-time 0";

      # Z = "SCRIPT-MESSAGE-TO SEEK_TO TOGGLE-SEEKER";
      # Z = "SCRIPT-MESSAGE-TO SEEK_TO PASTE-TIMESTAMP";
      y = "add sub-delay -0.1";
      Y = "add sub-delay +0.1";

      # o = "script-message-to uosc flash-elements timeline,top_bar";
      # O = "script-binding uosc/flash-ui";

      "+" = "add volume 5";
      "-" = "add volume -5";
      WHEEL_UP = "add volume 2";
      WHEEL_DOWN = "add volume -2";
      # Todo: the rest of the uosc overrides
    };
  };
}
