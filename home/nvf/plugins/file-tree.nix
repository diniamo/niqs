{
  programs.nvf.settings.vim = {
    filetree.neo-tree = {
      enable = true;

      setupOpts = {
        close_if_last_window = true;
        filesystem = {
          hijack_netrw_behavior = "open_current";
          follow_current_file.enabled = true;
        };
      };
    };

    maps.normal."<C-e>" = {
      desc = "Toggle Neotree";
      action = "<cmd>Neotree toggle reveal<cr>";
    };
  };
}
