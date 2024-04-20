{
  osConfig,
  pkgs,
  config,
  ...
}: let
  cfg = osConfig.modules.style;
in {
  qt = {
    enable = true;
    platformTheme = "qtct";
    # style.name = "kvantum";
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      custom_palette=true
      color_scheme_path=${config.xdg.configHome}/qt5ct/colors/default.conf
      icon_theme=${cfg.iconTheme.name}
      style=kvantum

      [Fonts]
      general="${cfg.font.name},${cfg.font.sizeString},-1,5,50,0,0,0,0,0,Regular"
      fixed="${cfg.monoFont.name},${cfg.monoFont.sizeString},-1,5,50,0,0,0,0,0,Regular"
    '';
    "qt5ct/colors/default.conf".source = cfg.qt.theme.colorScheme;

    kdeglobals.source = cfg.qt.kdeglobals;

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=default
    '';
    "Kvantum/default/default.kvconfig".source = cfg.qt.kvantum.config;
    "Kvantum/default/default.svg".source = cfg.qt.kvantum.svg;
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum
  ];

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    DISABLE_QT5_COMPAT = "0";

    CALIBRE_USE_DARK_PALETTE = "1";
    # libreoffice
    SAL_USE_VCLPLUGIN = "qt5";
  };
}
