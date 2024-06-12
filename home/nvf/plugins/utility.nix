{
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

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };
  };
}
