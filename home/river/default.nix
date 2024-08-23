{pkgs, ...}: {
  imports = [
    ./config.nix
    ./maps.nix
    ./spawn.nix
  ];

  home.packages = with pkgs; [
    wlr-randr
    wayshot
    slurp
    gammastep
  ];

  wayland.windowManager.river = {
    enable = true;
    # package = null;
  };
}
