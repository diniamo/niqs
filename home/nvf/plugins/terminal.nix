{config, ...}: {
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;

      mappings.open = "<c-t>";
      setupOpts = {
        winbar.enabled = false;
        direction = "float";
        float_opts.border = config.programs.nvf.settings.vim.ui.borders.globalStyle;
        highlights.FloatBorder.link = "FloatBorder";
      };
    };

    maps.terminal.${config.programs.nvf.settings.vim.terminal.toggleterm.mappings.open} = {
      desc = "Close terminal";
      action = "<cmd>ToggleTerm<cr>";
    };
  };
}
