{config, ...}: {
  programs.nvf = {
    settings.vim = {
      notify.nvim-notify = {
        enable = true;
        setupOpts = {
          render = "wrapped-compact";
          stages = "fade";
        };
      };

      ui = {
        noice = {
          enable = true;
          setupOpts = {
            cmdline = {
              view = "cmdline";
              format = {
                cmdline.conceal = false;
                search_down.conceal = false;
                search_up.conceal = false;
                filter.conceal = false;
                lua.conceal = false;
                help.conceal = false;
                input.conceal = false;
              };
            };
            popupmenu.backend = "cmp";
            views.popupmenu.scrollbar = false;
            notify.enabled = false;
          };
        };
        illuminate.enable = true;
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
        indent-blankline = {
          enable = true;
          setupOpts = {
            indent.tab_char = "│";
          };
        };
        highlight-undo.enable = true;
        nvim-web-devicons.enable = true;
      };
    };

    custom.setupPlugins = {
      bufresize = {
        package = config.programs.nvf.custom.sources.bufresize-nvim;
        setupOpts = {
          register = {
            keys = {};
            trigger_events = ["WinResized"];
          };
        };
      };
    };
  };
}
