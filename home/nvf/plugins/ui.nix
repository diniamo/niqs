{
  lib,
  config,
  inputs,
  ...
}: {
  programs.nvf.settings.vim = {
    notify.nvim-notify.enable = true;
    statusline.lualine.enable = true;
    ui = {
      illuminate.enable = true;
      noice.enable = true;
    };

    visuals = {
      enable = true;

      highlight-undo.enable = true;
      indentBlankline = {
        enable = true;
        fillChar = null;
        # TODO: the module is wrong, make a pr
        eolChar = null;
        showEndOfLine = true;
      };
      nvimWebDevicons.enable = true;
    };

    tabline.nvimBufferline = {
      enable = true;
      mappings = {
        closeCurrent = "<leader>bd";
        cycleNext = "<Tab>";
        cyclePrevious = "<S-Tab>";
        pick = "<leader>bp";
      };
      setupOpts = {
        highlights = let
          inherit (config.lib.stylix.colors.withHashtag) base04 base05 base0D;
          inherit (lib.generators) mkLuaInline;
          inherit (inputs.nvf.lib.nvim.lua) toLuaObject;

          highlights = {
            styles = ["bold"];
            custom.all = {
              separator.fg = base04;
              separator_visible.fg = base04;
              separator_selected.fg = base05;
              offset_separator.fg = base04;
              modified.fg = base0D;
              modified_visible.fg = base0D;
              modified_selected.fg = base0D;
            };
          };
        in
          mkLuaInline "require('catppuccin.groups.integrations.bufferline').get(${toLuaObject highlights})";
        options = {
          always_show_bufferline = false;
          auto_toggle_bufferline = true;
          numbers = "none";
          indicator.style = "none";
        };
      };
    };
  };
}
