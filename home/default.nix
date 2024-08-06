{
  lib,
  osConfig,
  ...
}: let
  username = osConfig.values.mainUser;
in {
  imports = [
    ./hyprland
    # ./anyrun
    ./mpv
    # ./lazyvim
    # ./zsh
    ./delta
    ./nvf
    ./starship
    # ./river
    ./style
    ./fish

    ./xdg.nix
    ./foot.nix
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
    # ./swappy.nix
    # ./i3.nix
    ./mangohud.nix
    ./lazygit.nix
    ./nix-index.nix
    ./less.nix
    ./btop.nix
    ./bat.nix
    ./zathura.nix
    ./swayimg.nix
    # ./alacritty.nix
    ./scripts.nix
    ./hyprpaper.nix
    # ./iabm.nix
    ./nyaa.nix
    ./satty.nix
    # ./walker.nix
    ./fuzzel.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = lib.mkDefault "23.11";
  };
}
