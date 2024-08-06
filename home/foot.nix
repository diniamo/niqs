{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        selection-target = "clipboard";

        # dpi-aware = true;
        pad = "10x10 center";
      };
      scrollback.lines = 10000;
      tweak.font-monospace-warn = "no";
      cursor.style = "beam";
      mouse.hide-when-typing = "yes";
    };
  };
}
