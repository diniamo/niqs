{config, ...}: {
  programs.neovim = {
    enable = true;
    package = config.wrappedPkgs.neovim;
    defaultEditor = true;
  };

  # TODO: find a way to have the configuration specified in the wrapped package
  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
