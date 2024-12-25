{config, ...}: {
  programs.nvf.settings.vim.lazy.plugins.harpoon2 = {
    package = config.programs.nvf.custom.sources.harpoon2;

    after = ''
      require('harpoon'):setup({
        settings = {
          save_on_toggle = true
        }
      })
    '';

    keys = [
      {
        desc = "Harpoon current buffer";
        mode = "n";
        key = "<C-a>";
        action = "function() require('harpoon'):list():add() end";
        lua = true;
      }
      {
        desc = "Harpoon menu";
        mode = "n";
        key = "<leader>h";
        action = ''
          function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end
        '';
        lua = true;
      }

      {
        desc = "Focus 1st Harpoon";
        mode = "n";
        key = "<C-1>";
        action = "function() require('harpoon'):list():select(1) end";
        lua = true;
      }
      {
        desc = "Focus 2st Harpoon";
        mode = "n";
        key = "<C-2>";
        action = "function() require('harpoon'):list():select(2) end";
        lua = true;
      }
      {
        desc = "Focus 3st Harpoon";
        mode = "n";
        key = "<C-3>";
        action = "function() require('harpoon'):list():select(3) end";
        lua = true;
      }
      {
        desc = "Focus 4st Harpoon";
        mode = "n";
        key = "<C-4>";
        action = "function() require('harpoon'):list():select(4) end";
        lua = true;
      }
    ];
  };
}
