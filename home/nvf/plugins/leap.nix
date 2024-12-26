{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.binds) mkKeymap;
in {
  programs.nvf.settings.vim = {
    startPlugins = ["vim-repeat"];

    lazy.plugins = {
      leap-nvim = {
        package = "leap-nvim";

        keys = [
          (mkKeymap ["n" "x" "o"] "s" "<Plug>(leap)" {desc = "Jump forward";})
          (mkKeymap ["n" "x" "o"] "S" "<Plug>(leap-from-window)" {desc = "Jump backward";})
          (mkKeymap ["n" "o"] "gs" "function() require('leap.remote').action({ input = 'v' }) end" {
            desc = "Charwise remote jump";
            lua = true;
          })
          (mkKeymap ["n" "o"] "gS" "function() require('leap.remote').action({ input = 'V' }) end" {
            desc = "Linewise remote jump";
            lua = true;
          })
          (mkKeymap ["n" "o"] "g<C-s>" "function() require('leap.remote').action({ input = '' }) end" {
            desc = "Blockwise remote jump";
            lua = true;
          })
        ];
      };

      flit-nvim = {
        package = config.programs.nvf.custom.sources.flit-nvim;

        keys = [
          {mode = ["n" "x" "o"]; key = "f";}
          {mode = ["n" "x" "o"]; key = "F";}
          {mode = ["n" "x" "o"]; key = "t";}
          {mode = ["n" "x" "o"]; key = "T";}
        ];

        setupModule = "flit";
        setupOpts = {
          labeled_modes = "";
        };
      };
    };
  };
}
