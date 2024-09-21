{config, ...}: let
  cfg = config.stylix;
in {
  config = {
    stylix.targets.kde.enable = false;

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    xdg.configFile = {
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        custom_palette=true
        color_scheme_path=${config.xdg.configHome}/qt5ct/colors/default.conf
        icon_theme=${cfg.icons.name}
        style=kvantum

        [Fonts]
        general="${cfg.fonts.sansSerif.name},${toString cfg.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
        fixed="${cfg.fonts.monospace.name},${toString cfg.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular"
      '';
      "qt5ct/colors/default.conf".source = cfg.targets.qt.colors;

      kdeglobals.source = cfg.targets.qt.kdeglobals;

      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=default
      '';
      "Kvantum/default/default.kvconfig".source = cfg.targets.qt.kvantum.config;
      "Kvantum/default/default.svg".source = cfg.targets.qt.kvantum.svg;
    };

    home.sessionVariables = {
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT5_COMPAT = "0";

      CALIBRE_USE_DARK_PALETTE = "1";
      # libreoffice
      SAL_USE_VCLPLUGIN = "qt5";
    };
  };
}
