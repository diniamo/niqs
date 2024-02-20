{ pkgs, lib, osConfig, ... }:
let
  inherit (lib) mkIf;

  cfg = osConfig.modules.style;
in {
  xdg.configFile = {
    kdeglobals.source = cfg.qt.kdeglobals.source;
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    breeze-icons
  ];

  home.sessionVariables = {
    # The scaling to use everywhere - 1 means no scaling
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    DISABLE_QT5_COMPAT = "0";
    CALIBRE_USE_DARK_PALETTE = "1";
  };

  qt = {
    enable = true;
    platformTheme = mkIf cfg.qt.forceGtk "gtk"; # just an override for QT_QPA_PLATFORMTHEME, takes “gtk”, “gnome”, “qtct” or “kde”
    style = mkIf (!cfg.qt.forceGtk) {
      name = cfg.qt.theme.name;
      package = cfg.qt.theme.package;
    };
  };
}
