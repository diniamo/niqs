{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins.harpoon2 = {
    package = pkgs.vimPlugins.harpoon2;

    after = ''
      require('harpoon'):setup({
        settings = {
          save_on_toggle = true
        }
      })
    '';

    keys = [
      {
        mode = "n";
        key = "<leader>a";
        desc = "Harpoon current buffer";
        action = "function() require('harpoon'):list():add() end";
        lua = true;
      }
      {
        mode = "n";
        key = "<leader>h";
        desc = "Harpoon menu";
        action = ''
          function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end
        '';
        lua = true;
      }

      {
        mode = "n";
        key = "<C-1>";
        desc = "Focus 1st Harpoon";
        action = "function() require('harpoon'):list():select(1) end";
        lua = true;
      }
      {
        mode = "n";
        key = "<C-2>";
        desc = "Focus 2st Harpoon";
        action = "function() require('harpoon'):list():select(2) end";
        lua = true;
      }
      {
        mode = "n";
        key = "<C-3>";
        desc = "Focus 3st Harpoon";
        action = "function() require('harpoon'):list():select(3) end";
        lua = true;
      }
      {
        mode = "n";
        key = "<C-4>";
        desc = "Focus 4st Harpoon";
        action = "function() require('harpoon'):list():select(4) end";
        lua = true;
      }
    ];
  };
}
