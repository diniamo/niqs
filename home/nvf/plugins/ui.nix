{
  flakePkgs,
  pkgs,
  ...
}: {
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

    maps.normal."<leader>ln" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };

  programs.nvf.modules.setupPlugins = {
    fastaction = {
      package = flakePkgs.niqspkgs.fastaction-nvim;
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
