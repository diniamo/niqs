{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.style.gtk = {
    usePortal = mkEnableOption "Use the native desktop portal for file pickers";

    theme = {
      name = mkOption {
        type = types.str;
        default = "Catppuccin-Macchiato-Standard-Blue-Dark";
        description = "The name of the GTK theme";
      };
      package = mkOption {
        type = types.package;
        description = "The GTK theme's package";
        default = pkgs.catppuccin-gtk.override {
          variant = "macchiato";
          size = "standard";
          accents = ["blue"];
          tweaks = ["normal"];
        };
      };
    };
  };
}
