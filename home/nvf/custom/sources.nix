{
  lib,
  lib',
  inputs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (lib') mapListToAttrs;
  inherit (builtins) path;

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
    mapListToAttrs (pname: let
      input = inputs.${pname};
      version = input.shortRev or input.shortDirtyRev or "dirty";
    in {
      name = pname;
      value = {
        # We don't inherit name directly because vim.lazy.plugins would cry
        # version isn't needed, but inherit it anyway for the sake of corectness
        inherit pname version;
        outPath = path {
          name = "${pname}-0-unstable-${version}";
          path = input.outPath;
        };
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
