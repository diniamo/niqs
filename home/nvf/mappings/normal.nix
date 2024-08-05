{
  programs.nvf.settings.vim = {
    binds.whichKey.register = {
      "<leader>h" = "+Help";
      "<leader>z" = "+Zoxide";
      "<leader>q" = "+Quit";
      "<leader>w" = "+Window";
    };

    maps.normal = {
      "<leader>;" = {
        desc = "Append ;";
        action = "A;<esc>";
      };
      "<leader>r" = {
        desc = "Redraw, clear hlsearch, update diff";
        action = "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-l><cr>";
      };
      "<leader>bD" = {
        desc = "Delete buffer and window";
        action = "<cmd>bd<cr>";
      };
      "<leader>bn" = {
        desc = "New file";
        action = "<cmd>enew<cr>";
      };
      "<leader>hk" = {
        desc = "Keymaps";
        action = "<cmd>Telescope keymaps<cr>";
      };
      "<leader>hc" = {
        desc = "Open cheatsheet";
        action = "<cmd>Cheatsheet<cr>";
      };
      "<leader>qq" = {
        desc = "Quit";
        action = "<cmd>q<cr>";
      };
      "<leader>qa" = {
        desc = "Quit all";
        action = "<cmd>qa<cr>";
      };
      "<leader>qf" = {
        desc = "Force quit all";
        action = "<cmd>qa!<cr>";
      };
      "<leader>qx" = {
        desc = "Save and quit all";
        action = "<cmd>xa<cr>";
      };
      "<leader>jj" = {
        desc = "Zoxide via input";
        lua = true;
        action = ''
          function()
            local keyword = vim.fn.input("Keyword: ")
            local directory = vim.fn.system({ "zoxide", "query", keyword }):match("(.*)[\n\r]")

            if directory == "" or directory == nil then
              vim.notify("No match found", vim.log.levels.ERROR)
            else
              vim.notify(directory)
              vim.fn.chdir(directory)
            end
          end
        '';
      };

      "<CR>" = {
        desc = "Insert line below";
        action = "o<esc>";
      };
      "<S-CR>" = {
        desc = "Insert line above";
        action = "O<esc>";
      };

      "<leader>ww" = {
        desc = "Other window";
        action = "<C-W>p";
        noremap = false;
      };
      "<leader>wd" = {
        desc = "Delete window";
        action = "<C-W>c";
        noremap = false;
      };
      "<leader>w-" = {
        desc = "Split window below";
        action = "<C-W>s";
        noremap = false;
      };
      "<leader>w|" = {
        desc = "Split window right";
        action = "<C-W>v";
        noremap = false;
      };
      "<leader>wf" = {
        desc = "Fullscreen window";
        action = "<cmd>NeoZoomToggle<cr>";
      };

      "gco" = {
        desc = "Add comment below";
        action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      };
      "gcO" = {
        desc = "Add comment above";
        action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      };
    };
  };
}
