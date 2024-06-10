{
  programs.nvf.settings.vim = {
    notify.nvim-notify.enable = true;
    statusline.lualine.enable = true;
    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<leader>bd";
        cycleNext = "<Tab>";
        cyclePrevious = "<S-Tab>";
        pick = "<leader>bp";
      };
    };

    ui = {
      illuminate.enable = true;
      noice.enable = true;
    };

    visuals = {
      enable = true;

      highlight-undo.enable = true;
      indentBlankline = {
        enable = true;
        fillChar = null;
        # TODO: the module is wrong, make a pr
        eolChar = null;
        showEndOfLine = true;
      };
      nvimWebDevicons.enable = true;
    };
  };
}
