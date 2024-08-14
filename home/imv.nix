{config, ...}: let
  cfg = config.stylix;
  inherit (config.lib.stylix) colors;
in {
  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = colors.base00;
        overlay = false;
        overlay_font = "${cfg.fonts.sansSerif.name}:${toString cfg.fonts.sizes.applications}";
        overlay_text_color = colors.base05;
        overlay_background_color = colors.base00;
        overlay_position_bottom = true;
      };

      binds = {
        r = "rotate by 90";
        "<Shift+R>" = "rotate by -90";
        "<Ctrl+R>" = "rotate to 0";

        x = "close";
        "<Shift+X>" = "quit";

        d = "exec gtrash put \"$imv_current_file\"; close";
        "<Shift+D>" = "exec rm \"$imv_current_file\"; close";

        i = "overlay";
        n = "center; reset";
      };
    };
  };
}
