{ config, lib, ... }: let
  inherit (lib) getExe;

  inherit (config) custom;
  inherit (custom) style;
in {
  custom = {
    style.matugen.templates.fuzzel-colors.input = ./colors.ini;

    fuzzel = {
      enable = true;

      settings = {
        main = {
          include = style.matugen.templates.fuzzel-colors.output;
          font = "${style.fonts.regular.name}:size=20";
          icon-theme = style.iconTheme.name;

          dpi-aware = false;
          prompt = "'   '";
          match-counter = true;
          lines = 8;
          line-height = 50;
          inner-pad = 5;
          horizontal-pad = 10;
          width = 45;
          show-actions = true;
          terminal = getExe custom.foot.finalPackage;
        };

        key-bindings = {
          first = "Control+Home Mod1+less";
          last = "Control+End Mod1+greater";
        };
      };
    };
  };
}
