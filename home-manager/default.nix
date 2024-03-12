{
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkDefault;
  inherit (osConfig) values;
in {
  imports = [
    ./hyprland
    ./style
    ./anyrun
    ./btop
    ./mpv
    ./lazyvim
    ./zsh
    ./zathura
    ./bat

    ./xdg.nix
    ./foot.nix
    ./schizofox.nix
    ./git.nix
    ./ncspot.nix
    ./bash.nix
    ./imv.nix
    # ./nixvim.nix
    ./yazi.nix
    ./starship.nix
    ./zoxide.nix
    ./wlogout.nix
    ./jerry.nix
    ./lobster.nix
  ];

  home = {
    username = "${values.mainUser}";
    homeDirectory = "/home/${values.mainUser}";
    stateVersion = mkDefault "23.11";
  };
}
