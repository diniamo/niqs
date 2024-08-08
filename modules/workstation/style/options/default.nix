{config, ...}: let
  imports = [
    ./fonts.nix
    ./icons.nix
    ./qt.nix
  ];
in {
  inherit imports;
  config.home-manager.users.${config.values.mainUser}.imports = imports;
}
