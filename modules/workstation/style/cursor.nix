{ lib, config, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) str int package;
  inherit (builtins) toString;

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
        XCURSOR_SIZE = toString cfg.size;
      };
    };
  };
}
