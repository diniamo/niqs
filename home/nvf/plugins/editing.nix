{
  programs.nvf.settings.vim = {
    autopairs.enable = true;
    utility.surround = {
      enable = true;
      mappings = {
        change = "gsr";
        delete = "gsd";
        insert = "<C-g>s";
        insertLine = "<C-g>S";
        normal = "gs";
        normalCur = "gS";
        normalCurLine = "gSS";
        normalLine = "gss";
        visual = "gs";
        visualLine = "gS";
      };
    };
    comments.comment-nvim.enable = true;

    binds.whichKey.register."gs" = "+Surround";
  };
}
