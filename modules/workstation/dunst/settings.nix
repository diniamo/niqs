{ config, ... }: let
  inherit (config.custom) style;
in {
  custom = {
    style.matugen.templates.dunstrc-colors.input = ./colors;

    dunst = {
      enable = true;

      configFiles = [ style.matugen.templates.dunstrc-colors.output ];
      settings = {
        global = {
          follow = "mouse";
          gap_size = 8;
          corner_radius = 10;
          offset = "10x10";

          mouse_left_click = "do_action, open_url, close_current";
          mouse_middle_click = "close_current";
          mouse_right_click = "context";

          font = "${style.fonts.regular.name} 10";
          icon_path = "";
          icon_theme = style.iconTheme.name;
          enable_recursive_icon_lookup = true;
        };
      };
    };
  };
}
