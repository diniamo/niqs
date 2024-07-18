{inputs, ...}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter;
in {
  programs.nvf.settings.vim = {
    filetree.nvimTree = {
      enable = true;

      mappings.toggle = "<leader>to";

      openOnSetup = false;
      setupOpts = {
        actions.open_file.quit_on_open = true;
        diagnostics.enable = true;
        git.enable = true;
      };
    };

    luaConfigRC.nvimTreeOpen = entryAfter ["pluginConfigs"] ''
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end
      })
    '';
  };
}
