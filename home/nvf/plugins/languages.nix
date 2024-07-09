{
  programs.nvf.settings.vim.languages = {
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    # bash.enable = true;
    lua.enable = true;
    # markdown.enable = true;
    nix.enable = true;
    python.enable = true;
    rust = {
      enable = true;
      crates.enable = true;
    };
    # clang.enable = true;
    markdown.enable = true;
  };
}
