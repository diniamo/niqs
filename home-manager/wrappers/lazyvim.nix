{pkgs, ...}: let
  extraPackages = with pkgs; [
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
  wrappers.neovim = {
    basePackage = pkgs.neovim-unwrapped;
    pathAdd = extraPackages;
  };
}
