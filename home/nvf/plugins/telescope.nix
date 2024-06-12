{
  lib',
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter;
in {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;

      setupOpts = {
        defaults = {
          layout_config.horizontal.prompt_position = "bottom";
          sorting_strategy = "descending";
          mappings.i."<esc>" = lib'.inlineLua "require('telescope.actions').close";
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

    optPlugins = [pkgs.vimPlugins.telescope-zf-native-nvim];
    # telescope is already required as a part of the telescope entry
    luaConfigRC.telescope-extensions = entryAfter ["telescope"] ''
      telescope.load_extension('zf-native')
    '';

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
