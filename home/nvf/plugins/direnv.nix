{flakePkgs, ...}: {
  programs.nvf.modules.setupPlugins.direnv = {
    package = flakePkgs.niqspkgs.direnv-nvim;
    setupOpts = {
      keybindings = {
        allow = "<leader>ea";
        deny = "<leader>ed";
        reload = "<leader>er";
      };
    };
  };

  programs.nvf.settings.vim.binds.whichKey.register."<leader>e" = "+Direnv";
}
