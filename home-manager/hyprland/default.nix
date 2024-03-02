{
  inputs,
  system,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (inputs) hyprland;
in {
  imports = [
    hyprland.homeManagerModules.default

    ./config.nix
    ./binds.nix
    ./exec.nix
  ];

  home.packages = [
    flakePkgs.hyprwm-contrib.grimblast
    pkgs.hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${system}.default;

    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
