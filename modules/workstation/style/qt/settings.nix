{ config, ... }: let
  cfg = config.custom.style;

  general = "${cfg.fonts.regular.name},${cfg.fonts.regular.sizeString}";
  fixed = "${cfg.fonts.monospace.name},${cfg.fonts.monospace.sizeString}";
in {
  custom.style = {
    matugen.templates.qtct-colors.input = ./qtct-colors.conf;

    qt = {
      shared = {
        Appearance = {
          custom_palette = true;
          color_scheme_path = cfg.matugen.templates.qtct-colors.output;
          icon_theme = cfg.iconTheme.name;
        };
      };

      qt5ct = {
        Fonts = {
          general = "${general},-1,5,50,0,0,0,0,0";
          fixed = "${fixed},-1,5,50,0,0,0,0,0";
        };
      };

      qt6ct = {
        Fonts = {
          general = "${general},-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
          fixed = "${fixed},-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        };
      };
    };
  };
}
