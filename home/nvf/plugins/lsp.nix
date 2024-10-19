{
  # programs.nvf.modules.lspSources = {
  #   nixd = {
  #     package = pkgs.nixd;
  #     arguments = ["--semantic-tokens=false"];
  #     settings.nixpkgs.expr = "import <nixpkgs> {}";
  #     extra = true;
  #   };
  # };

  programs.nvf.settings.vim = {
    lsp = {
      mappings = {
        renameSymbol = "<leader>lr";
        format = "<leader>f";
      };

      # lightbulb.enable = true;
      lspSignature.enable = true;
      lspkind.enable = true;
      # lsplines.enable = true;
      # lspsaga.enable = true;

      trouble = {
        enable = true;
        mappings = {
          documentDiagnostics = "<leader>xd";
          lspReferences = "<leader>xr";
        };
      };
    };

    binds.whichKey.register = {
      "<leader>l" = "+Lsp";
      "<leader>lg" = "+Goto";
      "<leader>lt" = "+Toggle";
    };
  };
}
