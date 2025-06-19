{ lib, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) bool path;
in {
  imports = [
    ./qt
    ./gtk
    
    ./matugen.nix
    ./fonts.nix
    ./cursor.nix
    ./icon-theme.nix
    ./settings.nix
  ];

  options = {
    custom.style = {
      dark = mkOption {
        type = bool;
        description = "Whether the theme is dark.";
      };

      wallpaper = mkOption {
        type = path;
        description = "The wallpaper to set and use for generating colors.";
      };
    };
  };
}
