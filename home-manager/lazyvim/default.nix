{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    neovim
    gnumake # this is needed for Luasnip's jsregexp to compile
  ];

  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
