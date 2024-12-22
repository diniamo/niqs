{
  config,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    lazy.plugins."oil.nvim" = {
      package = config.programs.nvf.custom.sources.oil-nvim;
      setupModule = "oil";

      cmd = "Oil";

      keys = [
        {
          mode = "n";
          key = "<C-e>";
          desc = "Toggle Oil";
          action = "<cmd>Oil<CR>";
        }
      ];

      setupOpts = {
        skip_confirm_for_simple_edits = true;

        use_default_keymaps = false;
        keymaps = mkLuaInline ''
          {
            ["<CR>"] = { "actions.select", mode = "n" },
            ["|"] = { "actions.select", mode = "n", opts = { vertical = true } },
            ["_"] = { "actions.select", mode = "n", opts = { horizontal = true } },
            ["<C-p>"] = { "actions.preview", mode = "n" },
            ["<C-e>"] = { "actions.close", mode = "n" },
            ["<F5>"] = { "actions.refresh", mode = "n" },
            ["<BS>"] = { "actions.parent", mode = "n" },
            ["gc"] = { "actions.open_cwd", mode = "n" },
            ["gy"] = { "actions.cd", mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = { "actions.open_external", mode = "n" },
            ["gh"] = { "actions.toggle_hidden", mode = "n" },
            ["gt"] = { "actions.toggle_trash", mode = "n" },
            ["<C-c>"] = { "actions.yank_entry", mode = "n" }
          }
        '';
      };
    };

    pluginRC.loadOil = ''
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            require("lz.n").trigger_load("oil.nvim")
          end
        end
      })
    '';
  };
}
