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
            NavicText = { fg = colors.text },
            NavicSeparator = { fg = colors.flamingo }
          }
        end,

        default_integrations = true,
        integrations = {
          flash = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          markdown = true,
          noice = true,
          cmp = true,
          dap = true,
          dap_ui = true,
          native_lsp = { enabled = true },
          navic = { enabled = true },
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
