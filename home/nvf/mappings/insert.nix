{
  programs.nvf.settings.vim.maps.insert = {
    "<C-BS>" = {
      desc = "Delete word behind";
      action = "<C-w>";
    };
    "<C-Del>" = {
      desc = "Delete word in front";
      action = "<C-o>de";
    };
    "," = {
      desc = "Insert undo breakpoint";
      action = ",<c-g>u";
    };
    "." = {
      desc = "Insert undo breakpoint";
      action = ".<c-g>u";
    };
    ";" = {
      desc = "Insert undo breakpoint";
      action = ";<c-g>u";
    };
  };
}
