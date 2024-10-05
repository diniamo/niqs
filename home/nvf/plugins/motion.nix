{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.modules.setupPlugins.flash = {
    package = pkgs.vimPlugins.flash-nvim;
    setupOpts = {
      prompt.enabled = false;
      modes.char.char_actions = mkLuaInline ''
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
}
