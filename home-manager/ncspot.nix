{osConfig, ...}: {
  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      notify = true;
      shuffle = true;
      volnorm = true;

      library_tabs = ["playlists" "albums" "artists" "browse" "podcasts" "tracks"];

      keybindings = {
        Left = "seek -5s";
        Up = "seek +30s";
        Right = "seek +5s";
        Down = "seek -30s";
        R = "seek -24h";

        gg = "move up 500";
        G = "move down 500";

        m = "voldown 100";
        M = "volup 100";

        Space = "playpause";
        "í" = "previous";
        y = "next";

        "+" = "volup 5";
        "-" = "voldown 5";
      };

      theme = {
        highlight_bg = "${osConfig.modules.style.colorScheme.colors.base02}";
      };
    };
  };
}
