{
  config,
  lib,
  inputs,
  ...
}: {
  programs.nvf.settings.vim.tabline = {
    nvimBufferline = {
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
          offsets = [
            {
              filetype = "neo-tree";
              highlight = "Directory";
              separator = true;
              text = "File Tree";
            }
          ];
        };
      };
    };
  };
}
