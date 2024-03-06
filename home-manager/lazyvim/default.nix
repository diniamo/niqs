{
  pkgs,
  config,
  ...
}: let
  packages = with pkgs; [
    # For luasnip/jsregexp
    gnumake

    # LSPs
    lua-language-server
    nil
    nodePackages.bash-language-server
    shellcheck

    # Formatters
    alejandra
    stylua
    shfmt
  ];
in {
  home.packages = packages;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
