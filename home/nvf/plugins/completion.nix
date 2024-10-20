{
  programs.nvf.settings = {
    vim.autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        scrollDocsUp = "<C-b>";
        close = "<C-c>";
      };
    };
    vim.snippets.luasnip.enable = true;
  };
}
