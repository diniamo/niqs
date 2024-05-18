{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings.vim = {
      viAlias = false;
      vimAlias = false;

      enableLuaLoader = true;
      enableEditorconfig = true;
      useSystemClipboard = true;
      hideSearchHighlight = true;
      searchCase = "smart";
      splitRight = true;
      spellcheck = {
        enable = true;
        languages = ["en" "hu"];
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };

      autocomplete = {
        enable = true;
        mappings.scrollDocsUp = "<C-b>";
      };
      autopairs.enable = true;
      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };
      comments.comment-nvim.enable = true;
      debugger.nvim-dap = {
        enable = true;
        ui.enable = true;
      };
      git.enable = true;
      # minimap.codeview.enable = true;
      notes = {
        obsidian.enable = true;
        todo-comments.enable = true;
      };
      notify.nvim-notify.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      terminal.toggleterm = {
        enable = true;
        # lazygit.enable = true;
      };
      # breadcrumbs.enable = true;
      # colorizer.enable = true;
      ui = {
        illuminate.enable = true;
        noice.enable = true;
      };
      utility = {
        # images.image-nvim.enable = true;
        # preview.markdownPreivew.enable = true;
        surround.enable = true;
        vim-wakatime.enable = true;
      };
      visuals = {
        highlight-undo.enable = true;
        indentBlankLine.enable = true;
        nvimWebDevicons = true;
      };

      lsp = {
        # lightbulb.enable = true;
        lspSignature = true;
        lspkind.enable = true;
        lsplines.enable = true;
        # lspsaga.enable = true;
        trouble.enable = true;
      };
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;

        bash.enable = true;
        # css.enable = true;
        # html.enable = true;
        # lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        # python.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
      };
    };
  };
}
