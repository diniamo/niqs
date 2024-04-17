{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.values = {
    terminal = mkOption {
      description = "The terminal command to run";
      type = types.str;
      default = "foot";
    };
  };
}
