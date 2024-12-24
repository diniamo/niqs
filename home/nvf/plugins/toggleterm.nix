{config, ...}: let
cfg = config.programs.nvf.settings.vim.terminal.toggleterm;
in {
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;

      mappings.open = "<C-t>";
      setupOpts = {
        direction = "float";
        float_opts.border = config.programs.nvf.settings.vim.ui.borders.globalStyle;
        highlights.FloatBorder.link = "FloatBorder";
      };
    };

    lazy.plugins.toggleterm-nvim = {
      keys = [
        {
          mode = "n";
          key = "<C-g>";
        }
      ];

      after = ''
        local lazygit = require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", hidden = true })
        vim.keymap.set({ "n", "t" }, "<C-g>", function() lazygit:toggle() end, { silent = true, noremap = true, desc = "Open lazygit" })
      '';
    };

    maps.terminal = {
      ${cfg.mappings.open} = {
        desc = "Close terminal";
        action = "<cmd>ToggleTerm<cr>";
      };
    };
  };
}
