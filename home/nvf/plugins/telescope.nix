{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;

      setupOpts = {
        defaults = {
          layout_config.horizontal.prompt_position = "bottom";
          sorting_strategy = "descending";
          mappings.i = {
            "<Esc>" = mkLuaInline "require('telescope.actions').close";
            "<C-j>" = mkLuaInline "require('telescope.actions').move_selection_next";
            "<C-k>" = mkLuaInline "require('telescope.actions').move_selection_previous";
            "<S-Tab>" = mkLuaInline "require('telescope.actions').move_selection_next";
            "<Tab>" = mkLuaInline "require('telescope.actions').move_selection_previous";
            # Clears the prompt
            "<C-u>" = false;
          };
        };
      };

      mappings = {
        buffers = "<leader>sb";
        diagnostics = "<leader>slD";
        findFiles = "<leader>sf";
        findProjects = "<leader>sp";
        gitBranches = "<leader>svb";
        gitBufferCommits = "<leader>svcb";
        gitCommits = "<leader>svcw";
        gitStash = "<leader>svx";
        gitStatus = "<leader>svs";
        helpTags = "<leader>sh";
        liveGrep = "<leader>sg";
        lspDefinitions = "<leader>sld";
        lspDocumentSymbols = "<leader>slsb";
        lspImplementations = "<leader>sli";
        lspReferences = "<leader>slr";
        lspTypeDefinitions = "<leader>slt";
        lspWorkspaceSymbols = "<leader>slsw";
        open = "<leader>so";
        resume = "<leader>sr";
        treesitter = "<leader>ss";
      };
    };

    lazy.plugins.telescope = {
      after = ''
        local telescope = require("telescope")
        telescope.load_extension("zf-native")
        telescope.load_extension("zoxide")
      '';

      keys = [
        {
          mode = "n";
          key = "<leader>sk";
          desc = "Keymaps [Telescope]";
          action = "<cmd>Telescope keymaps<cr>";
        }
        {
          mode = "n";
          key = "<leader>ji";
          desc = "Zoxide list [Telescope]";
          action = "function() require('telescope').extensions.zoxide.list() end";
          lua = true;
        }
      ];
    };
  };

  programs.nvf.custom.sanitizedStartPlugins = with pkgs.vimPlugins; [
    telescope-zf-native-nvim
    telescope-zoxide
  ];
}
