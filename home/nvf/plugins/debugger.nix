{
  programs.nvf.settings.vim = {
    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
    languages.enableDAP = true;

    binds.whichKey.register = {
      "<leader>d" = "+DAP";
      "<leader>dg" = "+Step";
      "<leader>dv" = "+Stacktrace";
    };
  };
}
