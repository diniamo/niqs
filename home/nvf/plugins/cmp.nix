{config,...}:{
  programs.nvf.settings = {
    vim.autocomplete.nvim-cmp = {
      enable = true;

      sourcePlugins = [config.programs.nvf.custom.sources.cmp-nvim-lua];
      sources.nvim_lua = null;

      mappings = {
        scrollDocsUp = "<C-b>";
        close = "<C-c>";
      };

      format = null;
      setupOpts = {
        completion.autocomplete = false;

        window = {
          completion.scrollbar = false;
          documentation.scrollbar = false;
        };
      };
    };

    vim.snippets.luasnip.enable = true;
  };
}
