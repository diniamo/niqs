{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;

  eval = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      ./lazyvim.nix
    ];
  };
in {
  options.wrappedPkgs = mkOption {
    description = "Wrapped packages for hm modules";
    type = types.attrs;
  };
  config.wrappedPkgs = eval.config.build.packages;
}
