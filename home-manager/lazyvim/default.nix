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
    nodePackages.bash-language-server
    shellcheck

    alejandra
    stylua
    shfmt
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
