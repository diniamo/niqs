{
  inputs,
  flakePkgs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default

    ./config.nix
    ./binds.nix
    ./exec.nix
    ./scripts.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
    gammastep

    flakePkgs.hyprwm-contrib.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # Installed by the NixOS module
    package = null;

    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
