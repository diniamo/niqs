{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
  inherit (config.stylix) fonts;

  package = pkgs.swayimg.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "artemsen";
      repo = "swayimg";
      rev = "f2bbe7535d80c55e9b743306f22bc22530b78582";
      hash = "sha256-FQshKPtpbJ2TgA/hJRLYK+QUTX6YarV8nfZGujkmxao=";
    };
  };

  settings = {
    general = {
      # TODO: enable this once performance is better
      antialiasing = false;
      fixed = false;
      transparency = colors.base02;
      background = colors.base00;
    };
    font = {
      inherit (fonts.sansSerif) name;
      size = fonts.sizes.applications;
      color = colors.base05;
      shadow = colors.base01;
    };
    info."full.topleft" = "name, imagesize, filesize";
    keys = {
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

      d = "exec rmtrash '%'; status 'Trashed %'";
      "Shift+d" = "exec rm '%'; status 'Deleted %'";
      Delete = "exec rm '%'; status 'Deleted %'";
      y = "exec wl-copy < '%'; status 'Copied image'";
      "Shift+y" = "exec wl-copy '%'; status 'Copied image path'";
    };
    mouse = {
      ScrollUp = "zoom +5";
      ScrollDown = "zoom -5";
    };
  };
in {
  home.packages = [package];
  xdg.configFile."swayimg/config".text = lib.generators.toINI {} settings;
}
