{pkgs, ...}: {
  programs.nvf = {
    settings.vim = {
      languages = {
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
        odin.enable = true;
      };

      # HACK: figure out a good way to upstream this
      debugger.nvim-dap.sources = {
        zig-debugger = "dap.configurations.zig = dap.configurations.cpp";
        odin-debugger = "dap.configurations.odin = dap.configurations.cpp";
      };
    };

    custom.lspSources = {
      basedpyright = {
        package = pkgs.basedpyright // {meta.mainProgram = "basedpyright-langserver";};
        arguments = ["--stdio"];

        settings = {
          typeCheckingMode = "standard";
        };
      };
    };
  };
}
