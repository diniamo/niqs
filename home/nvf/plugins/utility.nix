{pkgs, ...}: {
  programs.nvf.settings.vim = {
    utility = {
      # images.image-nvim.enable = true;
      # preview.markdownPreivew.enable = true;
      vim-wakatime.enable = true;
    };

    extraPlugins.vim-startuptime.package = pkgs.vimPlugins.vim-startuptime;

    notes.todo-comments = {
      enable = true;
      mappings = {
        quickFix = null;
        telescope = "<leader>st";
        trouble = "<leader>xt";
      };
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };
  };
}
