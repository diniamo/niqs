{inputs, ...}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter;
in {
  programs.nvf.settings.vim = {
    filetree.nvimTree = {
      enable = true;

      mappings.toggle = "<leader>to";

      openOnSetup = false;
      setupOpts = {
        diagnostics.enable = true;
        git.enable = true;
      };
    };

    # This can technically be anywhere, but might as well have it where it makes sense
    luaConfigRC.nvimTreeOpen = entryAfter ["nvimtreelua"] ''
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
