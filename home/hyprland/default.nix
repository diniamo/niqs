{
  flakePkgs,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./binds.nix
    ./exec.nix
    ./scripts.nix
    ./xdph.nix
  ];

  home.packages = with pkgs; [
    hyprpicker

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
