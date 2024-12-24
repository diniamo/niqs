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
        renameSymbol = "<leader>r";
        format = "<leader>f";
        codeAction = "<leader>a";
        hover = null;

        goToDeclaration = "gD";
        goToDefinition = "gd";
        listImplementations = "gi";
        listReferences = "gr";
        nextDiagnostic = "gn";
        previousDiagnostic = "gn";
      };

      # lightbulb.enable = true;
      lspSignature.enable = true;
      lspkind.enable = true;
      # lsplines.enable = true;
      # lspsaga.enable = true;

      trouble = {
        enable = true;
        mappings = {
          workspaceDiagnostics = "<leader>xw";
          documentDiagnostics = "<leader>xd";
          lspReferences = "<leader>xr";
        };
      };
    };
  };
}
