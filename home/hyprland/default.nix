{
  inputs,
  flakePkgs,
  pkgs,
  lib,
  config,
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

  xdg.configFile."hypr/hyprland.conf".onChange = "${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} reload";
}
