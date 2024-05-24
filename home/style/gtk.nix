{
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.modules.style;
in {
  xdg.systemDirs.data = let
    schema = pkgs.gsettings-desktop-schemas;
  in ["${schema}/share/gsettings-schemas/${schema.name}"];

  home = {
    packages = with pkgs; [
      glib
      cfg.gtk.theme.package
      cfg.iconTheme.package
    ];

    sessionVariables = {
      GTK_THEME = cfg.gtk.theme.name;
    };
  };

  gtk = {
    enable = true;
    theme = {inherit (cfg.gtk.theme) name package;};
    iconTheme = {inherit (cfg.iconTheme) name package;};
    font = {inherit (cfg.font) name size;};

    gtk2.extraConfig = ''
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-decoration-layout = "appmenu:none";
      gtk-button-images = 1;
      gtk-menu-images = 1;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "appmenu:none";
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = true;
    };
  };

  xdg.configFile."xsettingsd/xsettingsd.conf".text = ''
    Net/ThemeName "${cfg.gtk.theme.name}"
    Gtk/CursorThemeName "${cfg.cursor.name}"
    Gtk/CursorThemeSize ${toString cfg.cursor.size}
    Net/IconThemeName "${cfg.iconTheme.name}"
    Gtk/FontName "${cfg.font.name}, ${toString cfg.font.size}"
    Gtk/DecorationLayout "appmenu:none"
  '';
}
