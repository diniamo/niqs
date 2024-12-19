{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim.lazy.plugins."oil.nvim" = {
    package = pkgs.vimPlugins.oil-nvim;
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
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["|"] = { "actions.select", opts = { vertical = true } },
          ["_"] = { "actions.select", opts = { horizontal = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-e>"] = { "actions.close", mode = "n" },
          ["<F5>"] = "actions.refresh",
          ["<BS>"] = { "actions.parent", mode = "n" },
          ["~"] = { "actions.open_cwd", mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = { "actions.open_external", mode = "n" },
          ["gh"] = { "actions.toggle_hidden", mode = "n" },
          ["gt"] = { "actions.toggle_trash", mode = "n" },
        }
      '';
    };
  };
}
