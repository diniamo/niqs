{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (builtins) removeAttrs;
in {
  options = {
    programs.nvf.custom.sanitizedStartPlugins = mkOption {
      type = types.listOf types.package;
      default = [];
      description = ''
        An abstraction over `vim.startPlugins` that removes the `dependencies`
        attribute of nixpkgs plugin derivations. This is needed because it
        messes with plugins that are added internally (especially with lz.n).
      '';
    };
  };

  config = {
    programs.nvf.settings.vim.startPlugins =
      map (p: removeAttrs p ["dependencies"])
      config.programs.nvf.custom.sanitizedStartPlugins;
  };
}
