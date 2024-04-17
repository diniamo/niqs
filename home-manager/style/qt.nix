{osConfig, pkgs, ...}: let
  cfg = osConfig.modules.style.qt;
in {
  qt = {
    enable = true;
    # platformTheme = "gtk";
    style = {
      name = "kvantum";
      inherit (cfg.theme) package;
    };
  };

  xdg.configFile = {
    kdeglobals.source = cfg.kdeglobals;

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=default
    '';
    "Kvantum/default/default.kvconfig".source = cfg.kvantum.config;
    "Kvantum/default/default.svg".source = cfg.kvantum.svg;
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    DISABLE_QT5_COMPAT = "0";
    CALIBRE_USE_DARK_PALETTE = "1";
  };
}
