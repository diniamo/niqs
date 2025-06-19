{ lib, config, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) str int package;

  cfg = config.custom.style.cursor;
in {
  options = {
    custom.style.cursor = {
      name = mkOption {
        type = str;
        description = "The name of the cursor theme.";
      };

      size = mkOption {
        type = int;
        description = "The size of the cursor.";
      };
      sizeString = mkOption {
        type = str;
        default = toString cfg.size;
        readOnly = true;
        description = "The size of the cursor as a string.";
      };

      package = mkOption {
        type = package;
        description = "The package providing the cursor theme.";
      };
    };
  };

  config = {
    environment = {
      systemPackages = [ cfg.package ];
      sessionVariables = {
        XCURSOR_THEME = cfg.name;
        XCURSOR_SIZE = cfg.sizeString;
      };
    };
  };
}
