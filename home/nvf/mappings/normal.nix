{
  programs.nvf.settings.vim = {
    binds.whichKey.register = {
      "<leader>j" = "+Zoxide";
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
      "<C-q>" = {
        desc = "Jump to unsaved buffer or quit";
        action = ''
          function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_get_option_value("modified", { buf = buf }) then
                vim.api.nvim_win_set_buf(0, buf)
                return
              end
            end

            vim.cmd("quitall")
          end
        '';
        lua = true;
      };
      "<leader>jp" = {
        desc = "Zoxide prompt";
        lua = true;
        action = ''
          function()
            local keyword = vim.fn.input("Keyword: ")
            if keyword == "" then return end

            local directory = vim.fn.system({ "zoxide", "query", keyword }):match("(.*)[\n\r]")
            if directory == "zoxide: no match found" then
              vim.notify("No match found", vim.log.levels.ERROR)
            else
              vim.fn.chdir(directory)
              vim.notify(directory)
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

      "<C-g>" = {
        desc = "Copy file path to system clipboard";
        lua = true;
        action = ''
          function()
            local path = vim.api.nvim_buf_get_name(0)
            vim.fn.setreg('+', path)
            vim.notify('Copied "' .. path .. '"')
          end
        '';
      };
    };
  };
}
