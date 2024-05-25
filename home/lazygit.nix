{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        language = "en";
        # I can't find where these are used, but I should change them once I do
        # timeFormat = "";
        # shortTimeFormat = "";
        nerdFontsVersion = 3;
        filterMode = "fuzzy";
      };
      update.method = "never";
    };
  };
}
