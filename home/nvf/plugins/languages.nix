{pkgs, ...}: {
  programs.nvf.settings.vim.languages = {
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    bash.enable = true;
    lua.enable = true;
    nix.enable = true;
    python = {
      enable = true;
      # nvf doesn't allow changing lsp settings currently,
      # so I'm forced to define the entire lsp myself, see below
      lsp.enable = false;
    };
    rust = {
      enable = true;
      crates.enable = true;
    };
    clang.enable = true;
    markdown.enable = true;
    # nu.enable = true;
    # csharp.enable = true;
    # julia = {
    #   enable = true;
    #   # Provide it in devshells instead
    #   lsp.package = null;
    # };
    zig.enable = true;
  };

  programs.nvf.custom.lspSources = {
    basedpyright = {
      package = pkgs.basedpyright // {meta.mainProgram = "basedpyright-langserver";};
      arguments = ["--stdio"];

      settings = {
        typeCheckingMode = "standard";
      };
    };
  };
}
