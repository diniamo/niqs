{
  osConfig,
  pkgs,
  lib',
  config,
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
      GTK_THEME = "${cfg.gtk.theme.name}";
      GTK_USE_PORTAL = "${toString (lib'.boolToNum cfg.gtk.usePortal)}";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = cfg.gtk.theme.name;
      package = cfg.gtk.theme.package;
    };
    iconTheme = {
      name = cfg.iconTheme.name;
      package = cfg.iconTheme.package;
    };
    font = {
      name = cfg.font.name;
      size = cfg.font.size;
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };
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
}
