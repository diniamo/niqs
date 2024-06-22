{
  lib,
  osConfig,
  ...
}: let
  username = osConfig.values.mainUser;
in {
  imports = [
    ./hyprland
    ./anyrun
    ./mpv
    # ./lazyvim
    ./zsh
    ./delta
    ./nvf
    ./starship
    ./river

    ./xdg.nix
    # ./foot.nix
    ./schizofox.nix
    ./git.nix
    # ./ncspot.nix
    # ./imv.nix
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
    ./less.nix
    ./btop.nix
    ./bat.nix
    ./qt.nix
    ./gtk.nix
    ./stylix.nix
    ./zathura.nix
    ./swayimg.nix
    ./alacritty.nix
    ./scripts.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = lib.mkDefault "23.11";
  };
}
