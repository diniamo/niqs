{lib, ...}: let
  inherit (lib) mkOption types;

  fontPathOption = mkOption {
    type = types.path;
    description = "The path of the base font file";
  };
in {
  options = {
    stylix.fonts = {
      sansSerif.path = fontPathOption;
      serif.path = fontPathOption;
      emoji.path = fontPathOption;
      monospace.path = fontPathOption;
    };
  };
}
