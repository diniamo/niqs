{ config, ... }: let
  inherit (config.custom) style;
in {
  custom = {
    style.matugen.templates.swaylock-colors.input = ./colors;

    swaylock = {
      enable = true;

      configFiles = [ style.matugen.templates.swaylock-colors.output ];
      settings = {
        font = style.fonts.regular.name;
        font-size = 16;
        image = config.custom.style.wallpaper;
        scaling = "fill";
        indicator-idle-visible = true;
      };
    };
  };
}
