{
  inputs,
  flakePkgs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default

    ./config.nix
    ./binds.nix
    ./exec.nix
    ./scripts.nix
  ];

  home.packages = [
    flakePkgs.hyprwm-contrib.grimblast
    pkgs.hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = flakePkgs.hyprland.default;

    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  # This is also done in the home-manager module, but it doesn't work(?)
  xdg.configFile."hypr/hyprland.conf".onChange = "'${lib.getExe' flakePkgs.hyprland.default "hyprctl"}' -i 0 reload";
}
