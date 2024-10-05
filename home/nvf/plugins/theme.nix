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

        default_integrations = false,
        integrations = {
          flash = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          markdown = true,
          neotree = true,
          noice = true,
          cmp = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" }
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" }
            },
            inlay_hints = { background = true }
          },
          navic = {
            enabled = true,
            custom_bg = "NONE"
          },
          notify = true,
          nvim_surround = true,
          treesitter = true,
          telescope = { enabled = true },
          lsp_trouble = true,
          which_key = true
        }
      })

      vim.cmd("colorscheme catppuccin")
    '';
  };
}
