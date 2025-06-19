{ lib, config, ... }: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) attrsOf oneOf str bool int float path nullOr;
  inherit (lib.generators) toINI;

  cfg = config.custom.style.gtk;

  settingsFile = mkIf (cfg.settings != {}) {
    name = "gtk-settings.ini";
    text = toINI {} { Settings = cfg.settings; };
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.style.gtk = {
      settings = mkOption {
        type = attrsOf (oneOf [ str bool int float ]);
        default = {};
        description = "Settings to write to `.config/gtk-{3,4}.0/settings.ini`.";
      };

      css3 = mkOption {
        type = nullOr path;
        default = null;
        description = "CSS to link to `.config/gtk-3.0/gtk.css`.";
      };

      css4 = mkOption {
        type = nullOr path;
        default = null;
        description = "CSS to link to `.config/gtk-4.0/gtk.css`.";
      };
    };
  };

  config = {
    home.files = {
      ".config/gtk-3.0/settings.ini" = settingsFile;
      ".config/gtk-4.0/settings.ini" = settingsFile;
      ".config/gtk-3.0/gtk.css" = mkIf (cfg.css3 != null) { source = cfg.css3; };
      ".config/gtk-4.0/gtk.css" = mkIf (cfg.css4 != null) { source = cfg.css4; };
    };
  };
}
