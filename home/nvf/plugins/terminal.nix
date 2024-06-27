{config, ...}: {
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;

      mappings.open = "<c-t>";
      setupOpts = {
        winbar.enabled = false;
        direction = "float";
        float_opts.border = config.programs.nvf.settings.vim.ui.borders.globalStyle;
      };

      lazygit = {
        enable = true;
        mappings.open = "<leader>gl";
      };
    };

    maps.terminal.${config.programs.nvf.settings.vim.terminal.toggleterm.mappings.open} = {
      desc = "Close terminal";
      action = "<cmd>ToggleTerm<cr>";
    };
  };
}
