{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.custom.setupPlugins.flash = {
    package = pkgs.vimPlugins.flash-nvim;
    setupOpts = {
      prompt.enabled = false;
      modes.char = {
        config = mkLuaInline ''
          function(opts)
            opts.autohide = opts.autohide or (vim.fn.mode(true) == "no")
          end
        '';

        char_actions = mkLuaInline ''
          function(motion)
            return {
              [";"] = "right",
              [","] = "left",
              [motion] = "next",
              [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
            }
          end
        '';
      };
    };
  };
}
