{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  inherit (config.stylix) fonts;

  settings = {
    font = {
      inherit (fonts.sansSerif) name;
      size = fonts.sizes.applications;
      color = colors.base05;
      shadow = colors.base01;
    };

    viewer = {
      # TODO: enable this once performance is better
      antialiasing = true;
      fixed = false;
      transparency = colors.base02;
      window = colors.base00;
    };

    "info.viewer".top_left = "name, imagesize, filesize";

    "keys.viewer" = {
      "0" = "first_file";
      "dollar" = "last_file";
      "Ctrl+h" = "prev_file";
      "Ctrl+l" = "next_file";
      f = "fullscreen";
      h = "step_left";
      j = "step_down";
      k = "step_up";
      l = "step_right";
      r = "rotate_right";
      "Shift+r" = "rotate_left";
      "Ctrl+r" = "reload";
      i = "info";
      "plus" = "zoom +10";
      "underscore" = "zoom +10";
      n = "zoom optimal";

      d = "exec gtrash put '%'; status 'Trashed %'";
      "Shift+d" = "exec rm '%'; status 'Deleted %'";
      Delete = "exec rm '%'; status 'Deleted %'";
      y = "exec wl-copy < '%'; status 'Copied image'";
      "Shift+y" = "exec wl-copy '%'; status 'Copied image path'";

      ScrollUp = "zoom +5";
      ScrollDown = "zoom -5";
    };
  };
in {
  home.packages = [pkgs.swayimg];
  xdg.configFile."swayimg/config".text = lib.generators.toINI {} settings;
}
