{ config, ... }: {
  custom = {
    style.matugen.templates.zathura-colors.input = ./colors;

    zathura = {
      enable = true;

      include = [ config.custom.style.matugen.templates.zathura-colors.output ];

      set = {
        vertical-center = true;
        selection-clipboard = "clipboard";
      };

      map = {
        h = "feedkeys '<C-Left>'";
        j = "feedkeys '<C-Down>'";
        k = "feedkeys '<C-Up>'";
        l = "feedkeys '<C-Right>'";
      };
    };
  };
}
