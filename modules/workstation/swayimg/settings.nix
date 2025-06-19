{ config, ... }: let
  inherit (config.custom) style;
in {
  custom = {
    style.matugen.templates.swayimg-colors.input = ./colors;

    swayimg = {
      enable = true;

      includes = [ style.matugen.templates.swayimg-colors.output ];
      settings = {
        general = {
          compositor = false;
        };

        font = {
          inherit (style.fonts.regular) name size;
        };

        viewer = {
          position = "free";
          preload = 2;
        };

        info = {
          show = false;
          info_timeout = 0;
        };

        "info.viewer" = {
          top_left = "name,imagesize,filesize";
          top_right = "index";
          bottom_left = "status";
          bottom_right = "none";
        };

        "keys.viewer" = {
          question = "help";
          "Shift+question" = "help";
          "Alt+less" = "first_file";
          "Alt+greater" = "last_file";
          p = "prev_file";
          n = "next_file";
          space = "next_file";
          f = "fullscreen";
          "plus" = "zoom +10";
          ScrollUp = "zoom +5";
          "underscore" = "zoom +10";
          ScrollDown = "zoom -5";
          c = "zoom optimal";
          less = "rotate_left";
          greater = "rotate_right";
          u = "flip_vertical";
          m = "flip_horizontal";
          "Ctrl+r" = "reload";
          i = "info viewer";
          q  = "exit";
          
          d = "exec gtrash put '%'; status 'Trashed %'";
          Delete = "exec rm '%'; status 'Deleted %'";
          y = "exec wl-copy '%'; status 'Copied image path'";
          "Shift+y" = "exec wl-copy < '%'; status 'Copied image'";
        };
      };
    };
  };
}
