{ config, lib, ... }:
let
  inherit (lib) mkEnableOption;

  cfg = config.modules.boot;
in {
  options.modules.boot = {
    windows_entry = mkEnableOption "Whether to add a Windows entry or not";
  };
}

