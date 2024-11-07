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
            "<esc>" = mkLuaInline "require('telescope.actions').close";
            "<C-j>" = mkLuaInline "require('telescope.actions').move_selection_next";
            "<C-k>" = mkLuaInline "require('telescope.actions').move_selection_previous";
            # Clears the prompt
            "<C-u>" = false;

            "<cr>" = mkLuaInline ''
              function(prompt_bufnr)
                local actions = require("telescope.actions")
                actions.add_selection(prompt_bufnr)
                actions.send_selected_to_qflist(prompt_bufnr)
                vim.cmd("cfdo edit")
              end
            '';
          };
        };
      };

      mappings = {
        buffers = "<leader>sb";
        diagnostics = "<leader>sld";
        findFiles = "<leader>sf";
        findProjects = "<leader>sp";
        gitBranches = "<leader>svb";
        gitBufferCommits = "<leader>svcb";
        gitCommits = "<leader>svcw";
        gitStash = "<leader>svx";
        gitStatus = "<leader>svs";
        helpTags = "<leader>ht";
        liveGrep = "<leader>sg";
        lspDefinitions = "<leader>slD";
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
          key = "<leader>ji";
          desc = "Zoxide list";
          lua = true;
          action = "function() require('telescope').extensions.zoxide.list() end";
        }
      ];
    };

    binds.whichKey.register = {
      "<leader>f" = null;
      "<leader>fl" = null;
      "<leader>fm" = null;
      "<leader>fv" = null;
      "<leader>fvc" = null;

      "<leader>s" = "+Telescope";
      "<leader>sl" = "+Lsp";
      "<leader>sv" = "+Git";
      "<leader>svc" = "+Commit";
      "<leader>j" = "+Zoxide";
    };
  };

  programs.nvf.custom.sanitizedStartPlugins = with pkgs.vimPlugins; [
    telescope-zf-native-nvim
    telescope-zoxide
  ];
}
