{ lib, pkgs, config, ... }:
let
  inherit (lib) mkOption types mkEnableOption;

  cfg = config.modules.style;
in {
  options.modules.style.qt = {
    forceGtk = mkEnableOption "Force the use of the QT style override with GTK";

    kdeglobals.source = mkOption {
      type = types.path;
      description = "The source file for kdeglobals";
      default = "${cfg.qt.theme.package}/share/color-schemes/CatppuccinMacchiatoBlue.colors";
    };

    theme = {
      name = mkOption {
        type = types.str;
	default = "Catppuccin-Macchiato-Dark";
	description = "The name of the QT theme";
      };
      package = mkOption {
        type = types.package;
	description = "The package for the QT theme";
	default = pkgs.catppuccin-kde.override {
          flavour = ["macchiato"];
	  accents = ["blue"];
	  winDecStyles = ["modern"];
	};
      };
    };
  };
}
