{ config, lib, pkgs, ... }: let
  cfg = config.custom.style;
  inherit (cfg.matugen) templates;

  gtkTheme = if cfg.dark then "adw-gtk3-dark" else "adw-gtk3";
  regularFont = "${cfg.fonts.regular.name} ${cfg.fonts.regular.sizeString}";
in {
  environment = {
    systemPackages = [ pkgs.adw-gtk3 ];
    sessionVariables.GTK_THEME = gtkTheme;
  };

  custom.style = {
    matugen.templates = {
      gtk3-colors.input = ./gtk3-colors.css;
      gtk4-colors.input = ./gtk4-colors.css;
    };

    gtk = {
      settings = {
        gtk-application-prefer-dark-theme = cfg.dark;
        gtk-cursor-theme-name = cfg.cursor.name;
        gtk-cursor-theme-size = cfg.cursor.size;
        gtk-font-name = regularFont;
        gtk-icon-theme-name = cfg.iconTheme.name;
        gtk-theme-name = gtkTheme;
      };

      css3 = templates.gtk3-colors.output;
      css4 = templates.gtk4-colors.output;
    };
  };
  
  programs.dconf = {
    enable = true;

    profiles.user.databases = let
      inherit (lib.gvariant) mkInt32;
    in [{
      settings."org/gnome/desktop/interface" = {
        icon-theme = cfg.iconTheme.name;
        gtk-theme = gtkTheme;
        font-name = regularFont;
        document-font-name = regularFont;
        monospace-font-name = "${cfg.fonts.monospace.name} ${cfg.fonts.monospace.sizeString}";
        cursor-theme = cfg.cursor.name;
        cursor-size = mkInt32 cfg.cursor.size;
        color-scheme = if cfg.dark then "prefer-dark" else "prefer-light";
      };
    }];
  };
}
