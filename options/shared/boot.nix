{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.boot = {
    windows_entry = mkEnableOption "Whether to add a Windows entry or not";
  };
}
