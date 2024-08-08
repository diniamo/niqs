{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) mkEnableTarget;
  inherit (lib) mkOption types;
in {
  options = {
    stylix = {
      targets.qt = {
        enable = mkEnableTarget "all QT apps." true;

        colors = mkOption {
          description = "The color scheme file for QT.";
          type = types.path;
        };
        kdeglobals = mkOption {
          description = "The kdeglobals file for QT.";
          type = types.path;
        };
        kvantum = {
          config = mkOption {
            type = types.path;
            description = "The path to the .kvconfig file";
          };
          svg = mkOption {
            type = types.path;
            description = "The path to the .svg file";
          };
        };
      };
    };
  };
}
