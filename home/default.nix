{
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkDefault;

  username = osConfig.values.mainUser;
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
    ./delta
    # ./nvf
    # ./alacritty
    ./starship

    ./xdg.nix
    ./foot.nix
    ./schizofox.nix
    ./git.nix
    # ./ncspot.nix
    ./bash.nix
    ./imv.nix
    ./yazi.nix
    ./zoxide.nix
    ./wlogout.nix
    ./jerry.nix
    ./lobster.nix
    ./direnv.nix
    ./dunst.nix
    ./spotify-player.nix
    ./fzf.nix
    # ./wezterm.nix
    ./swappy.nix
    # ./i3.nix
    ./mangohud.nix
    ./lazygit.nix
    ./nix-index.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = mkDefault "23.11";
  };
}
