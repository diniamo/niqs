{ config, ... }: let
  font = config.custom.style.fonts.monospace;
in {
  custom.foot = {
    enable = true;
    
    settings = {
      main = {
        include = "${./colors.ini}";
        font = "${font.name}:size=${font.sizeString}";
        selection-target = "clipboard";
        pad = "10x10 center";
        resize-by-cells = false;
        resize-keep-grid = false;
      };
      bell.system = false;
      scrollback.lines = 10000;
      tweak.font-monospace-warn = false;
      cursor.style = "beam";
      mouse.hide-when-typing = true;
    };
  };
}
