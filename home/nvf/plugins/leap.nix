{
  programs.nvf = {
    settings.vim = {
      startPlugins = [
        "vim-repeat"
        "leap-nvim"
      ];

      keymaps = [
        {
          desc = "Jump forward";
          mode = ["n" "x" "o"];
          key = "s";
          action = "<Plug>(leap)";
        }
        {
          desc = "Jump backward";
          mode = ["n" "x" "o"];
          key = "S";
          action = "<Plug>(leap-from-window)";
        }
        {
          desc = "Charwise remote jump";
          mode = ["n" "o"];
          key = "gs";
          action = "function() require('leap.remote').action({ input = 'v' }) end";
          lua = true;
        }
        {
          desc = "Linewise remote jump";
          mode = ["n" "o"];
          key = "gS";
          action = "function() require('leap.remote').action({ input = 'V' }) end";
          lua = true;
        }
        {
          desc = "Blockwise remote jump";
          mode = ["n" "o"];
          key = "g<C-s>";
          action = "function() require('leap.remote').action({ input = '<C-v>' }) end";
          lua = true;
        }
      ];
    };
  };
}
