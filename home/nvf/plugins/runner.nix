{
  programs.nvf.settings.vim = {
    runner.run-nvim = {
      enable = true;
      setupOpts = {
        auto_save = true;
      };
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;

      mappings = {
        restart = "<leader>dr";
        toggleRepl = "<leader>dR";
      };
    };
    languages.enableDAP = true;

    binds.whichKey.register = {
      "<leader>d" = "+DAP";
      "<leader>dg" = "+Step";
      "<leader>dv" = "+Stacktrace";
    };
  };
}
