{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default

    ./custom
    ./plugins

    ./settings.nix
    ./options.nix
  ];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings.vim.extraLuaFiles = [
      ./lua/options.lua
      ./lua/autocmds.lua
      ./lua/mappings.lua
    ];
  };

  home.sessionVariables.MANPAGER = "nvim -c 'Man!'";
}
