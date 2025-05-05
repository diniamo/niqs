{config, ...}: let
  imports = [
    ./fonts.nix
    ./icons.nix
  ];
in {
  inherit imports;
  config.home-manager.users.${config.values.mainUser}.imports = imports;
}
