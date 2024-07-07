{
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf submodule listOf nullOr str attrs;
  inherit (inputs.nvf.lib.nvim.types) pluginType;
  inherit (builtins) mapAttrs;
  inherit (inputs.nvf.lib.nvim.lua) toLuaObject;
in {
  options = {
    programs.nvf.modules.setupPlugins = mkOption {
      type = attrsOf (submodule {
        options = {
          package = mkOption {
            type = pluginType;
            description = "Plugin package";
          };

          after = mkOption {
            type = listOf str;
            default = [];
            description = "Put the setup function after the specified sections in the DAG order";
          };

          luaName = mkOption {
            type = nullOr str;
            default = null;
            description = ''
              The name used in the require call.

              By default, the name of the entry is used.
            '';
          };

          setupOpts = mkOption {
            type = attrs;
            default = {};
            description = "The options to pass to the setup call";
          };
        };
      });
      default = {};
      description = ''
        This is an abstraction over vim.extraPlugins, that uses setupOpts instead of setup.
      '';
    };
  };

  config = {
    programs.nvf.settings.vim.extraPlugins =
      mapAttrs (name: value: {
        inherit (value) package after;
        setup = "require('${
          if value.luaName == null
          then name
          else value.luaName
        }').setup(${toLuaObject value.setupOpts})";
      })
      config.programs.nvf.modules.setupPlugins;
  };
}
