{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf ((config.home-manager.users or {}) == {}) {
    environment = {
      systemPackages = [pkgs.neovim];
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  };
}
