{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkOption getExe optionalString;
  inherit (lib.types) attrsOf submodule package listOf str bool anything;
  inherit (inputs.nvf.lib.nvim.lua) toLuaObject;
  inherit (builtins) mapAttrs;
in {
  options = {
    programs.nvf.modules.lspSources = mkOption {
      type = attrsOf (submodule {
        options = {
          package = mkOption {
            type = package;
            description = "The package providing the language server";
          };

          arguments = mkOption {
            type = listOf str;
            default = [];
            description = "Arguments to pass to the language server";
          };

          settings = mkOption {
            type = attrsOf anything;
            default = {};
            description = "The settings to pass to the language server";
          };

          extra = mkOption {
            type = bool;
            default = false;
            description = "The attach function isn't passed for extra language servers";
          };
        };
      });
      default = {};
      description = "An abstraction over vim.lsp.lspconfig.sources";
    };
  };

  config = {
    programs.nvf.settings.vim.lsp.lspconfig.sources =
      mapAttrs (server: {
        package,
        arguments,
        settings,
        extra,
      }: ''
        lspconfig.${server}.setup {
          capabilities = capabilities,
          ${optionalString (!extra) "on_attach = default_on_attach,"}
          cmd = ${toLuaObject ([(getExe package)] ++ arguments)},
          settings = {
            ${server} = ${toLuaObject settings},
          },
        }
      '')
      config.programs.nvf.modules.lspSources;
  };
}
