{ lib, config, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) str package int;

  fontOptions = {
    name = mkOption {
      type = str;
      description = "The name of the font.";
    };

    size = mkOption {
      type = int;
      description = "The standard size to use for the font.";
    };
    
    package = mkOption {
      type = package;
      description = "The package providing the font.";
    };
  };

  cfg = config.custom.style.fonts;
in {
  options = {
    custom.style.fonts = {
      regular = fontOptions;
      monospace = fontOptions;
    };
  };

  config = {
    environment.systemPackages = [
      cfg.regular.package
      cfg.monospace.package
    ];
  };
}
