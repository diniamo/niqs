{
  inputs,
  pkgs,
  ...
}: let
  eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      ./neovim.nix
    ];
  };
in
  eval.config.build.packages
