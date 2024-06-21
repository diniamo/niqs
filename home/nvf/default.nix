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

    ./settings.nix

    ./plugins/theme.nix
    ./plugins/languages.nix
    ./plugins/debugger.nix
    ./plugins/cmp.nix
    ./plugins/editing.nix
    ./plugins/git.nix
    ./plugins/ui.nix
    ./plugins/lsp.nix
    ./plugins/telescope.nix
    ./plugins/terminal.nix
    ./plugins/utility.nix

    ./mappings/normal.nix
    ./mappings/insert.nix
    ./mappings/visual.nix
  ];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings.vim.luaConfigPost = builtins.concatStringsSep "\n" (map (path: lib.fileContents path) luaPaths);
  };
}
