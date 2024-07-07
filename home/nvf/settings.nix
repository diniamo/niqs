{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nvf.lib.nvim.dag) entryAfter;
  inherit (builtins) concatStringsSep;

  loadedVariables = [
    "g:loaded_getscriptPlugin"
    "loaded_gzip"
    "loaded_logiPat"
    "g:loaded_manpager_plugin"
    # "g:loaded_matchparen"
    "g:loaded_netrwPlugin"
    "loaded_rrhelper"
    "loaded_spellfile_plugin"
    "g:loaded_tarPlugin"
    "g:loaded_2html_plugin"
    "g:loaded_vimballPlugin"
    "g:loaded_zipPlugin"
  ];
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

    configRC.disablePlugins = entryAfter ["globalsScript"] (concatStringsSep "\n" (map (name: "let ${name} = 1") loadedVariables));

    luaConfigRC.neovide = ''
      if vim.g.neovide then
        vim.opt.guifont = "${config.stylix.fonts.monospace.name}:h${toString config.stylix.fonts.sizes.terminal}"
        vim.g.neovide_remember_window_size = false
      end
    '';
  };
}
