{
  programs.nvf.settings.vim = {
    maps.normal = {
      "<leader>;" = {
        desc = "Append ;";
        action = "A;<esc>";
      };
      "<leader>hc" = {
        desc = "Open cheatsheet";
        action = "<cmd>Cheatsheet<cr>";
      };
      "<leader>hk" = {
        desc = "Keymaps";
        action = "<cmd>Telescope keymaps<cr>";
      };

      "<CR>" = {
        desc = "Insert line below";
        action = "o<esc>";
      };
      "<S-CR>" = {
        desc = "Insert line above";
        action = "O<esc>";
      };
    };

    binds.whichKey.register."<leader>h" = "+Help";
  };
}
