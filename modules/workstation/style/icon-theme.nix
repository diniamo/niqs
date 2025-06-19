{ lib, config, ... }: let
  inherit (lib) mkOption;
  inherit (lib.types) str package;

  cfg = config.custom.style.iconTheme;
in {
  options = {
    custom.style.iconTheme = {
      name = mkOption {
        type = str;
        description = "The name of the icon theme.";
      };

      package = mkOption {
        type = package;
        description = "The package providing the icon theme.";
      };
    };
  };

  config = {
    environment.systemPackages = [ cfg.package ];
  };
}
