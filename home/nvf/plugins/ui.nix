{flakePkgs, ...}: {
  programs.nvf.settings.vim = {
    notify.nvim-notify.enable = true;
    ui = {
      illuminate.enable = true;

      noice = {
        enable = true;
        setupOpts.presets.bottom_search = false;
      };

      breadcrumbs = {
        enable = true;

        navbuddy = {
          enable = true;
          setupOpts.useDefaultMappings = false;
        };
      };
    };

    visuals = {
      enable = true;

      indentBlankline.enable = true;
      highlight-undo.enable = true;
      nvimWebDevicons.enable = true;
    };

    lsp.code-actions.enable = true;
    lsp.code-actions.fastaction-nvim = {
      enable = true;

      mappings = {
        code_action = null;
        range_action = null;
      };
      setupOpts = {
        dismiss_keys = ["q" "<esc>"];
        keys = "abcdefghijklmnoprstuvwxyz";
        popup = {
          title = "Select:";
          relative = "cursor";
        };
        register_ui_select = true;
      };
    };

    maps.normal."<leader>ln" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };

  programs.nvf.modules.setupPlugins = {
    dressing = {
      package = "dressing-nvim";
      setupOpts = {
        select.enabled = false;
      };
    };

    bufresize = {
      package = flakePkgs.niqspkgs.bufresize-nvim;
      setupOpts = {
        register = {
          keys = {};
          trigger_events = ["WinResized"];
        };
      };
    };
  };
}
