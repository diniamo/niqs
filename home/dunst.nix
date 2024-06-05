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
      };

      urgency_low.frame_color = mkForce colors.base0B;
      urgency_normal.frame_color = mkForce colors.base0D;
    };
    iconTheme = {
      inherit (config.stylix.icons) package name;
    };
  };
}
