{ inputs, pkgs, config, system, ... }: 
let
  inherit (inputs) hyprland;
in {
  imports = [
    hyprland.homeManagerModules.default
    ./config.nix
    ./binds.nix
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
