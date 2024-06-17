{
  programs.nvf.settings.vim = {
    binds.whichKey.register."<leader>h" = "+Help";

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
        desc = "Quit all";
        action = "<cmd>qa<cr>";
      };
      "<leader>q!" = {
        desc = "Force quit all";
        action = "<cmd>qa!<cr>";
      };
      "<leader>qx" = {
        desc = "Save and quit all";
        action = "<cmd>xa<cr>";
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

      "<C-h>" = {
        desc = "Go to left window";
        action = "<C-w>h";
        noremap = false;
      };
      "<C-j>" = {
        desc = "Go to lower window";
        action = "<C-w>j";
        noremap = false;
      };
      "<C-k>" = {
        desc = "Go to upper window";
        action = "<C-w>k";
        noremap = false;
      };
      "<C-l>" = {
        desc = "Go to right window";
        action = "<C-w>l";
        noremap = false;
      };

      "<C-Up>" = {
        desc = "Increase window height";
        action = "<cmd>resize +2<cr>";
      };
      "<C-Down>" = {
        desc = "Decrease window height";
        action = "<cmd>resize -2<cr>";
      };
      "<C-Left>" = {
        desc = "Decrease window width";
        action = "<cmd>vertical resize -2<cr>";
      };
      "<C-Right>" = {
        desc = "Increase window width";
        action = "<cmd>vertical resize +2<cr>";
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
