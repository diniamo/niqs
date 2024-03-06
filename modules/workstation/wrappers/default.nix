{
  inputs,
  pkgs,
  config,
  ...
}: let
  eval = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    specialArgs = {osConfig = config;};
    modules = [
      ./vesktop.nix
      ./obsidian.nix
    ];
  };
in {
  environment.systemPackages = [eval];
}
