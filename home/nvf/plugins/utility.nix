{config, ...}: {
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
  };

  programs.nvf.custom.setupPlugins = {
    nvim-lastplace.package = config.programs.nvf.custom.sources.nvim-lastplace;
  };
}
