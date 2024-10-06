{
  programs.nvf.settings.vim = {
    autopairs.enable = true;
    comments.comment-nvim.enable = true;
    utility.surround = {
      enable = true;
      useVendoredKeybindings = false;
      setupOpts.keymaps = {
        insert = "<C-g>s";
        insert_line = "<C-g>S";
        normal = "gs";
        normal_cur = "gS";
        normal_line = "gss";
        normal_cur_line = "gSS";
        visual = "gs";
        visual_line = "gS";
        delete = "gsd";
        change = "gsr";
        change_line = "gSR";
      };
    };
    snippets.vsnip.enable = true;

    binds.whichKey.register."gs" = "+Surround";
  };
}
