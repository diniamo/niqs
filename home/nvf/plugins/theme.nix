{inputs, ...}: let
  inherit (inputs.nvf.lib.nvim.dag) entryBefore;
in {
  programs.nvf.settings.vim.theme = {
    # HACK: the builtin theme module doesn't allow chainging setup options, which I need
    # enable = true;
    name = "catppuccin";
    style = "macchiato";
  };

  programs.nvf.settings.vim = {
    startPlugins = ["catppuccin"];
    luaConfigRC.theme = entryBefore ["pluginConfigs"] ''
      require("catppuccin").setup({
        flavour = "macchiato",
        term_colors = true,

        custom_highlights = function(colors)
          return {
            StatusLine = { fg = colors.none, bg = colors.none },
            StatusLineNC = { fg = colors.none, bg = colors.none }
          }
        end,

        default_integrations = true,
        integrations = {
          leap = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          markdown = true,
          notify = true,
          cmp = true,
          dap = true,
          dap_ui = true,
          native_lsp = { enabled = true },
          notify = true,
          nvim_surround = true,
          treesitter = true,
          telescope = { enabled = true },
          lsp_trouble = true
        }
      })

      vim.cmd("colorscheme catppuccin")
    '';
  };
}
