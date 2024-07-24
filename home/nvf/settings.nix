{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter entryBefore;
in {
  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = false;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    enableLuaLoader = true;
    enableEditorconfig = true;
    useSystemClipboard = true;
    hideSearchHighlight = true;
    searchCase = "smart";
    splitRight = true;
    spellcheck = {
      enable = true;
      languages = ["en" "hu"];
    };

    additionalRuntimePaths = [./runtime];

    ui.borders = {
      enable = true;
      # Maybe try to get `none` working at some point?
      globalStyle = "rounded";
    };

    luaConfigRC = {
      diagnosticIcons = entryBefore ["pluginConfigs"] ''
        vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})
      '';

      disablePlugins = entryAfter ["basic"] ''
        vim.g.loaded_getscriptPlugin = 1
        vim.g.loaded_gzip = 1
        vim.g.loaded_logiPat = 1
        vim.g.loaded_manpager_plugin = 1
        -- vim.g.loaded_matchparen = 1
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_rrhelper = 1
        vim.g.loaded_spellfile_plugin = 1
        vim.g.loaded_tarPlugin = 1
        vim.g.loaded_2html_plugin = 1
        vim.g.loaded_vimballPlugin = 1
        vim.g.loaded_zipPlugin = 1
      '';

      neovide = ''
        if vim.g.neovide then
          vim.opt.guifont = "${config.stylix.fonts.monospace.name}:h${toString config.stylix.fonts.sizes.terminal}"
          vim.g.neovide_remember_window_size = false
        end
      '';
    };
  };
}
