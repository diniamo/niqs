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
    ];
  };
in
  eval.config.build.packages
