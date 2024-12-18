{
  programs.nvf.settings.vim = {
    runner.run-nvim = {
      enable = true;

      mappings = {
        run = "<F10>";
        runOverride = "<S-F10>";
        runCommand = "<C-F10>";
      };

      setupOpts = {
        auto_save = true;
      };
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;

      mappings = {
        continue = "<F9>";
        restart = "<S-F9>";
        terminate = "<A-F9>";
        runLast = "<C-F9>";

        toggleRepl = null;
        hover = "<F2>";
        toggleBreakpoint = "<F8>";

        runToCursor = "<F7>";
        stepInto = "<F6>";
        stepOut = "<S-F6>";
        stepOver = "<C-F6>";
        stepBack = "<A-F6>";

        goUp = "<F2>";
        goDown = "<F3>";
      };
    };
    languages.enableDAP = true;
  };
}
