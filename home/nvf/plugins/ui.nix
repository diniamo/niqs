{
  lib,
  config,
  inputs,
  ...
}: {
  programs.nvf.settings.vim = {
    notify.nvim-notify.enable = true;
    ui = {
      illuminate.enable = true;
      noice.enable = true;
    };

    visuals = {
      enable = true;

      highlight-undo.enable = true;
      # TODO: Disable start-end display once this is converted to setupOpts
      indentBlankline = {
        enable = true;
        fillChar = null;
        eolChar = null;
        scope.showEndOfLine = true;
      };
      nvimWebDevicons.enable = true;
    };

    statusline.lualine = {
      enable = true;
      componentSeparator = {
        left = "";
        right = "";
      };
      sectionSeparator = {
        left = "";
        right = "";
      };
      activeSection = lib.mkForce {
        a = ["{ 'mode' }"];
        b = ["{ 'branch' }"];
        c = [
          ''
            {
              'diagnostics',
              symbols = { error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 ' }
            }
          ''
          ''
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 }
            }
          ''
          ''
            {
              "filename",
              symbols = { modified = ' ', readonly = ' ' },
            }
          ''
        ];
        x = [
          ''
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = 'Statement',
            }
          ''
          ''
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = 'Constant',
            }
          ''
          ''
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = 'Debug',
            }
          ''
          ''
            {
              "diff",
              diff_color = {
                added = 'DiffAdd',
                modified = 'DiffChange',
                removed = 'DiffDelete'
              },
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            }
          ''
        ];
        y = [
          "{ 'progress', separator = ' ', padding = { left = 1, right = 0 }}"
          "{ 'location', padding = { left = 0, right = 1 }}"
        ];
        z = [
          ''
            {
              function()
                return " " .. os.date("%R")
              end
            }
          ''
        ];
      };
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
