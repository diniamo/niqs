{
  programs.nvf.settings.vim.maps.normal = {
    "<leader>bf" = {
      desc = "Format buffer";
      lua = true;
      action = "vim.lsp.buf.format";
    };
    "<leader>;" = {
      desc = "Append ;";
      action = "A;<esc>";
    };
    "<leader>?" = {
      desc = "Open cheatsheet";
      action = "<cmd>Cheatsheet<cr>";
    };
  };
}
