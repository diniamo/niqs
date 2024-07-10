{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
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

    maps.normal."<leader>ln" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };

  programs.nvf.modules.setupPlugins.dressing = {
    package = "dressing-nvim";
    setupOpts = {
      builtin = {
        relative = "cursor";
        override = mkLuaInline ''
          function(opts)
            opts.row = 1;
            return opts;
          end
        '';

        mappings.q = "Close";
      };

      backend = "builtin";
    };
  };
}
