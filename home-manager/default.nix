{ lib, osConfig, ...}:
let
  inherit (lib) mkDefault;
  inherit (osConfig.modules) values;
in {
  imports = [
    ./hyprland
    ./style

    ./foot.nix
    ./mpv.nix
    ./schizofox.nix
    ./git.nix
    ./ncspot.nix
    ./bash.nix
  ];

  home = {
    username = "${values.mainUser}";
    homeDirectory = "/home/${values.mainUser}";
    stateVersion = mkDefault "23.11";
  };
}
