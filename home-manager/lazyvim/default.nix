{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    neovim

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

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
