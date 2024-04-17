{wrappedPkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = wrappedPkgs.neovim;
    defaultEditor = true;
  };

  # TODO: find a way to have the configuration specified in the wrapped package
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
