{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # For luasnip/jsregexp
    gnumake

    # LSPs and formatters
    lua-language-server
    nil
    alejandra
    stylua
    shfmt
    nodePackages.bash-language-server
    shellcheck
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  }

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
