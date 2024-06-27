{
  flakePkgs,
  config,
  ...
}: {
  programs.nvf.settings.vim = {
    notify.nvim-notify.enable = true;
    ui = {
      illuminate.enable = true;
      noice.enable = true;
      breadcrumbs = {
        enable = true;

        navbuddy = {
          enable = true;
          setupOpts.useDefaultMappings = false;
          mappings.help = "?";
        };
      };
    };

    visuals = {
      enable = true;

      highlight-undo.enable = true;
      # TODO: Disable start-end display once this is converted to setupOpts
      indentBlankline = {
        enable = true;
        fillChar = null;
        eolChar = null;
        scope.showEndOfLine = true;
      };
      nvimWebDevicons.enable = true;
    };

    extraPlugins = {
      dressing = {
        package = "dressing-nvim";
        after = ["noice-nvim"];
        setup = ''
          require("dressing").setup({
            builtin = {
              relative = "cursor",
              override = function(opts)
                opts.row = 1
                return opts
              end,

              mappings = {
                q = "Close"
              }
            },

            backend = "builtin"
          })
        '';
      };
    };

    maps.normal."<leader>ln" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };
}
