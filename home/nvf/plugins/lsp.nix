{
  programs.nvf.settings.vim = {
    lsp = {
      # lightbulb.enable = true;
      # lspSignature.enable = true;
      # lspkind.enable = true;
      lsplines.enable = true;
      # lspsaga.enable = true;
      trouble.enable = true;
    };

    binds.whichKey.register = {
      "<leader>l" = "+Lsp";
      "<leader>lg" = "+Goto";
      "<leader>lt" = "+Toggle";
    };
  };
}
