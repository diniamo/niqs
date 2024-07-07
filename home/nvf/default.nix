{
  inputs,
  lib,
  ...
}: let
  luaPaths = [
    ./lua/options.lua
    ./lua/autocmds.lua
    ./lua/mappings.lua
  ];
in {
  imports = [
    inputs.nvf.homeManagerModules.default

    ./modules
    ./plugins
    ./mappings

    ./settings.nix
  ];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings.vim.luaConfigPost = builtins.concatStringsSep "\n" (map (path: lib.fileContents path) luaPaths);
  };
}
