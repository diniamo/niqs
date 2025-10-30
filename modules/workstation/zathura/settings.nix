{ config, ... }: {
  custom = {
    style.matugen.templates.zathura-colors.input = ./colors;

    zathura = {
      enable = true;

      include = [ config.custom.style.matugen.templates.zathura-colors.output ];

      set = {
        vertical-center = true;
        selection-clipboard = "clipboard";
        guioptions = "";
      };

      map = {
        h = "feedkeys <C-Left>";
        j = "feedkeys <C-Down>";
        k = "feedkeys <C-Up>";
        l = "feedkeys <C-Right>";
        n = "navigate next";
        p = "navigate previous";
        i = "toggle_statusbar";
        ge = "goto bottom";
        "<Space>" = "snap_to_page";
      };
    };
  };
}
