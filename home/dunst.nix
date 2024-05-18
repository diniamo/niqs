{osConfig, ...}: let
  cfg = osConfig.modules.style;
in {
  services.dunst = {
    enable = true;

    settings = with cfg.colorScheme.colorsWithPrefix; {
      global = {
        follow = "mouse";
        gap_size = 8;
        corner_radius = 10;
        offset = "10x10";

        font = "${cfg.font.name} ${cfg.font.sizeString}";

        separator_color = "frame";
        frame_color = base0D;
      };

      urgency_low = {
        background = base00;
        foreground = base05;
      };

      urgency_normal = {
        background = base00;
        foreground = base05;
      };

      urgency_critical = {
        background = base00;
        foreground = base05;
        frame_color = base09;
      };
    };
    iconTheme = {
      inherit (cfg.iconTheme) name package;
    };
  };
}
