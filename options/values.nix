{ lib, ... }:
let
  inherit (lib) mkOption types;
in {
  options.modules.values = {
    mainUser = mkOption { type = types.str; };
    terminal = mkOption { type = types.str; };
  };

  config.modules.values = {
    mainUser = "diniamo";
    terminal = "foot";
  };
}
