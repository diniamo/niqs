{inputs, ...}: {
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
  ];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;
  };
}
