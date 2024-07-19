{pkgs, ...}: {
  programs.nvf.modules.setupPlugins.flash = {
    package = pkgs.vimPlugins.flash-nvim;
    setupOpts = {
      prompt.enabled = false;
    };
  };
}
