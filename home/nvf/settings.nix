{config, ...}: {
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

    luaConfigRC.neovide = ''
      if vim.g.neovide then
        vim.opt.guifont = "${config.stylix.fonts.monospace.name}:h${toString config.stylix.fonts.sizes.terminal}"
        vim.g.neovide_remember_window_size = false
      end
    '';
  };
}
