{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.style;
in {
  xdg.configFile = {
    kdeglobals.source = cfg.qt.kdeglobals.source;
  };

  home.packages = with pkgs; [
    cfg.qt.theme.package
  ];

  home.sessionVariables = {
    # The scaling to use everywhere - 1 means no scaling
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    DISABLE_QT5_COMPAT = "0";
    CALIBRE_USE_DARK_PALETTE = "1";
  };

  qt = {
    enable = true;
    # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
    platformTheme = "gtk";
    # style = {
    #   name = cfg.qt.theme.name;
    #   package = cfg.qt.theme.package;
    # };
  };
}
