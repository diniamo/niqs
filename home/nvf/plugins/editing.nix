{config, ...}: {
  programs.nvf.settings.vim = {
    autopairs.nvim-autopairs.enable = true;
    comments.comment-nvim.enable = true;
    utility.surround = {
      enable = true;
      useVendoredKeybindings = false;
    };

    lazy.plugins.no-neck-pain-nvim = {
      package = config.programs.nvf.custom.sources.no-neck-pain-nvim;

      event = "BufEnter";

      cmd = [
        "NoNeckPain"
        "NoNeckPainResize"
        "NoNeckPainToggleLeftSide"
        "NoNeckPainToggleRightSide"
        "NoNeckPainWidthUp"
        "NoNeckPainWidthDown"
        "NoNeckPainScratchPad"
      ];

      keys = [
        {
          mode = "n";
          key = "<leader>n";
          action = "<cmd>NoNeckPain<cr>";
        }
      ];

      setupModule = "no-neck-pain";
      setupOpts = {
        autocmds.enableOnVimEnter = true;
      };
    };
  };
}
