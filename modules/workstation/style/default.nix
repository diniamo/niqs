{ lib, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) bool;
in {
  imports = [
    ./qt
    
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
    };
  };
}
