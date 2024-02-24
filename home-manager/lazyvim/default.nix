{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    neovim

    # For luasnip/jsregexp
    gnumake

    # Packages needed for mason
    unzip
    nodePackages.npm
    nodejs-slim
    shellcheck
  ];

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
