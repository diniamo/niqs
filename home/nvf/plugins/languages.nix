{pkgs, ...}: {
  programs.nvf = {
    settings.vim = {
      lsp.enable = true;
      
      languages = {
        enableExtraDiagnostics = false;
        enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;
        lua = {
          enable = true;
          lsp.enable = false;
        };
        nix.enable = true;
        python = {
          enable = true;
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
        # zig.enable = true;
        odin.enable = true;
        # kotlin.enable = true;
      };

      # HACK: figure out a good way to upstream this
      debugger.nvim-dap.sources = {
        # zig-debugger = "dap.configurations.zig = dap.configurations.cpp";
        odin-debugger = "dap.configurations.odin = dap.configurations.cpp";
      };
    };

    # nvf doesn't allow changing lsp settings currently,
    # so I'm forced to redefined the lsps if I want to do that
    custom.lspSources = {
      basedpyright = {
        package = pkgs.basedpyright // {meta.mainProgram = "basedpyright-langserver";};
        arguments = ["--stdio"];

        settings.basedpyright = {
          typeCheckingMode = "standard";
        };
      };

      lua_ls = {
        package = pkgs.lua-language-server;

        settings.Lua = {
          diagnostics.globals = ["vim"];
        };
      };
    };
  };
}
