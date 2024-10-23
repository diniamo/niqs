{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;

  colors = config.lib.stylix.colors.withHashtag;
in {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "mouse";
        gap_size = 8;
        corner_radius = 10;
        offset = "10x10";

        mouse_left_click = "do_action, open_url, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "context";

        icon_path = mkForce "";
        icon_theme = config.stylix.icons.name;
        enable_recursive_icon_lookup = true;
      };

      urgency_low.frame_color = mkForce colors.base0C;
      urgency_normal.frame_color = mkForce colors.base0D;
    };
  };
}
