{
  inputs,
  pkgs,
  ...
}: let
  eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      ./neovim.nix
      ./xdragon.nix
      ./nvidia.nix
    ];
  };
in
  eval.config.build.packages
