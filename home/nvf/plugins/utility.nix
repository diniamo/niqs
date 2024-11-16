{
  pkgs,
  flakePkgs,
  ...
}: {
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
    nvim-lastplace.package = pkgs.vimPlugins.nvim-lastplace;
    neo-zoom = {
      package = flakePkgs.niqspkgs.neozoom-lua;
      setupOpts.winopts = {
        offset = {
          width = 1;
          height = 1;
        };

        border = "none";
      };
    };
  };
}
