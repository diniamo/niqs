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

      fastaction = {
        enable = true;
        setupOpts = {
          dismiss_keys = ["q" "<esc>"];
          keys = "abcdefghijklmnoprstuvwxyz";
          popup = {
            title = "Select:";
            relative = "cursor";
          };
        };
      };
    };

    visuals = {
      indent-blankline.enable = true;
      highlight-undo.enable = true;
      nvim-web-devicons.enable = true;
    };

    maps.normal."<leader>ln" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };

  programs.nvf.custom.setupPlugins = {
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
