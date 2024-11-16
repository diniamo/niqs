{pkgs,...}:{
  programs.nvf.settings = {
    vim.autocomplete.nvim-cmp = {
      enable = true;

      sourcePlugins = [pkgs.vimPlugins.cmp-nvim-lua] ;
      sources.nvim_lua = null;

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
