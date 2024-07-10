{pkgs, ...}: {
  programs.nvf.settings.vim = {
    utility = {
      # images.image-nvim.enable = true;
      # preview.markdownPreivew.enable = true;
      vim-wakatime.enable = true;
    };

    notes.todo-comments = {
      enable = true;
      mappings = {
        quickFix = null;
        telescope = "<leader>st";
        trouble = "<leader>xt";
      };
    };

    extraPlugins.startuptime.package = pkgs.vimPlugins.vim-startuptime;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };
  };

  programs.nvf.modules.setupPlugins.nvim-lastplace.package = pkgs.vimPlugins.nvim-lastplace;
}
