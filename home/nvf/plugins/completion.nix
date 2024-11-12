{
  programs.nvf.settings = {
    vim.autocomplete.nvim-cmp = {
      enable = true;

      mappings = {
        scrollDocsUp = "<C-b>";
        close = "<C-c>";
      };

      format = null;
      setupOpts = {
        window = {
          completion.scrollbar = false;
          documentation.scrollbar = false;
        };
      };
    };

    vim.snippets.luasnip.enable = true;
  };
}
