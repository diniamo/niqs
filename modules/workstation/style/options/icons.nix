{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options = {
    stylix = {
      icons = {
        package = mkOption {
          description = "Package providing the icons.";
          type = types.package;
        };
        name = mkOption {
          description = "The icons' name within the package.";
          type = types.str;
        };
      };
    };
  };
}
