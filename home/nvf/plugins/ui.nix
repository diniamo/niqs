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
            presets = {
              bottom_search = false;
              lsp_doc_border = false;
            };

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
