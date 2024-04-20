{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./style
    ./values.nix
  ];

  options = {
    xdg.portal.name = mkOption {
      description = "The name of the xdg desktop portal, used both in the package name and to specify the default portal";
      type = types.enum ["wlr" "gtk" "xapp" "gnome" "cosmic" "hyprland" "kde" "lxqt" "pantheon"];
      default = "kde";
    };
    tmpDownloadsDirectory = mkOption {
      description = "Whether to place the Downloads directory in /tmp";
      type = types.bool;
      default = true;
    };
  };
}
