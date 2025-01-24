{pkgs, ...}: {
  imports = [
    ./config.nix
    ./maps.nix
    ./spawn.nix
  ];

  stylix.targets.river.enable = false;

  home.packages = with pkgs; [
    wlr-randr
    wayshot
    slurp
  ];

  wayland.windowManager.river = {
    enable = true;
    # package = null;
  };
}
