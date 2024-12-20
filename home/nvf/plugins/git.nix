{
  programs.nvf.settings.vim = {
    git = {
      enable = true;
      # TODO: what does this do?
      vim-fugitive.enable = false;

      gitsigns.mappings = {
        stageHunk = "<leader>gs";
        undoStageHunk = "<leader>gu";
        resetHunk = "<leader>gr";
        stageBuffer = "<leader>gS";
        resetBuffer = "<leader>gR";
        previewHunk = "<leader>gP";
        blameLine = "<leader>gb";
        diffThis = "<leader>gd";
        diffProject = "<leader>gD";
        toggleBlame = "<leader>gtb";
        toggleDeleted = "<leader>gtd";
      };
    };
  };
}
