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

  services.hyprpaper.enable = lib.mkForce false;
}
