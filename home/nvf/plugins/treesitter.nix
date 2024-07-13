{pkgs, ...}: {
  programs.nvf.settings.vim.treesitter = {
    fold = true;

    # Why is c a default?
    addDefaultGrammars = false;
    grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      vim
      vimdoc
      query

      fish
      regex
    ];
  };
}
