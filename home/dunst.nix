{config, ...}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "mouse";
        gap_size = 8;
        corner_radius = 10;
        offset = "10x10";
      };
    };
    iconTheme = {
      inherit (config.stylix.icons) package name;
    };
  };
}
