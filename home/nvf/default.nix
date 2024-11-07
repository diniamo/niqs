{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default

    ./custom
    ./plugins
    ./mappings

    ./settings.nix
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
}
