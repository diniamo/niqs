{
  programs.nvf.settings.vim = {
    options = {
      cursorline = true;
      foldlevel = 99;
      # TODO: figure this out;
      # formatoptions = "jqln";
      laststatus = 3;
      linebreak = true;
      list = true;
      shiftround = true;
      showmode = false;
      sidescrolloff = 2;
      cindent = true;
      undofile = true;
      undolevels = 10000;
      virtualedit = "block";
      wildmode = "longest:full,full";
      winminwidth = 5;
      wrap = false;
      smoothscroll = true;
      gdefault = true;
      splitkeep = "cursor";
      cmdheight = 0;
      tabstop = 4;
      shiftwidth = 4;
    };

    globals = {
      markdown_recommended_style = 0;
    };
  };
}
