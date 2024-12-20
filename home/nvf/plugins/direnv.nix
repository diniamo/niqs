{config, ...}: {
  programs.nvf.custom.setupPlugins.direnv = {
    package = config.programs.nvf.custom.sources.direnv-nvim;
    setupOpts = {
      keybindings = {
        allow = "<leader>ea";
        deny = "<leader>ed";
        reload = "<leader>er";
      };
    };
  };
}
