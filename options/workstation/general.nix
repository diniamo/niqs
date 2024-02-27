{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.modules.general = {
    xdgDesktopPortal = mkOption {
      type = types.enum ["wlr" "gtk" "xapp" "gnome" "cosmic" "hyprland" "kde" "lxqt" "pantheon"];
      description = "The default xdg desktop portal to use";
      default = "gtk";
    };
  };
}
