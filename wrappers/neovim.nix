{pkgs, ...}: {
  wrappers.neovim = {
    basePackage = pkgs.neovim-unwrapped;
    pathAdd = with pkgs; [
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
  };
}
