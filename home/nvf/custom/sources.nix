{
  lib,
  lib',
  inputs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (lib') mapListToAttrs;

  sourceNames = [
    "bufresize-nvim"
    "direnv-nvim"
    "fastaction-nvim"
    "harpoon"
    "cmp-nvim-lua"
    "feline-nvim"
    "oil-nvim"
    "nvim-lastplace"
    "telescope-zf-native-nvim"
    "telescope-zoxide"
    "flit-nvim"
    "no-neck-pain-nvim"
  ];

  sources =
    mapListToAttrs (name: let
      input = inputs.${name};
    in {
      name = name;
      value = {
        pname = name;
        version = input.shortRev;
        outPath = input.outPath;
        passthru.vimPlugin = false;
      };
    })
    sourceNames;
in {
  options = {
    programs.nvf.custom.sources = mkOption {
      type = types.attrs;
      default = sources;
      readOnly = true;
      description = "External plugin sources";
    };
  };
}
