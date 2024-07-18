{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter entryBefore;
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    pluginRC.telescopeRequireActions = entryBefore ["telescope"] ''
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
    '';

    telescope = {
      enable = true;

      setupOpts = {
        defaults = {
          layout_config.horizontal.prompt_position = "bottom";
          sorting_strategy = "descending";
          mappings.i = {
            "<esc>" = mkLuaInline "actions.close";
            "<C-j>" = mkLuaInline "actions.move_selection_next";
            "<C-k>" = mkLuaInline "actions.move_selection_previous";

            "<cr>" = mkLuaInline ''
              function(prompt_bufnr)
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
        treesitter = "<leader>ss";
      };
    };

    startPlugins = with pkgs.vimPlugins; [
      telescope-zf-native-nvim
      telescope-zoxide
    ];
    # telescope is already required as a part of the telescope entry
    luaConfigRC.telescopeExtensions = entryAfter ["pluginConfigs"] ''
      telescope.load_extension('zf-native')
      telescope.load_extension('zoxide')
    '';
    maps.normal."<leader>zi" = {
      desc = "";
      lua = true;
      action = "telescope.extensions.zoxide.list";
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
    };
  };
}
