{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.binds) mkKeymap;
in {
  programs.nvf.settings.vim.lazy.plugins.direnv-nvim = {
    package = config.programs.nvf.custom.sources.direnv-nvim;

    event = "DeferredUIEnter";
    cmd = "Direnv";
    keys = [
      (mkKeymap "n" "<leader>ea" "<cmd>Direnv allow<cr>" {desc = "Allow .envrc";})
      (mkKeymap "n" "<leader>ed" "<cmd>Direnv deny<cr>" {desc = "Allow .envrc";})
      (mkKeymap "n" "<leader>er" "<cmd>Direnv reload<cr>" {desc = "Allow .envrc";})
    ];

    setupModule = "direnv";
    setupOpts = {
      auto_load = true;
    };
  };
}
