{
  config,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim.lazy.plugins."feline.nvim" = {
    package = config.programs.nvf.custom.sources.feline-nvim;

    event = "UIEnter";

    beforeSetup = ''
      local palette = require("catppuccin.palettes").get_palette()
      local vi_mode = require("feline.providers.vi_mode")
      local file = require("feline.providers.file")
      local cursor = require("feline.providers.cursor")

      local file_info_opts = {
        file_readonly_icon = " ",
        type = "relative"
      }
    '';

    setupModule = "feline";
    setupOpts = {
      theme = {
        fg = mkLuaInline "palette.text";
        bg = mkLuaInline "palette.mantle";
        black = mkLuaInline "palette.crust";
        skyblue = mkLuaInline "palette.sky";
        cyan = mkLuaInline "palette.teal";
        green = mkLuaInline "palette.green";
        oceanblue = mkLuaInline "palette.blue";
        magenta = mkLuaInline "palette.maroon";
        orange = mkLuaInline "palette.peach";
        red = mkLuaInline "palette.red";
        violet = mkLuaInline "palette.mauve";
        white = mkLuaInline "palette.text";
        yellow = mkLuaInline "palette.yellow";
      };

      force_inactive = {};
      disable.buftypes = [
        "^nofile$"
        "^terminal$"
        "^help$"
      ];

      components.active = [
        [
          {
            provider = mkLuaInline ''
              function()
                return " " .. vi_mode.get_vim_mode() .. " "
              end
            '';
            update = ["ModeChanged"];
            hl = mkLuaInline ''
              function()
                return {
                  name = vi_mode.get_mode_highlight_name(),
                  fg = "bg",
                  bg = vi_mode.get_mode_color(),
                  style = "bold"
                }
              end
            '';
            right_sep = " ";
          }
          {
            provider = "macro";
            hl = {
              name = "StatusComponentMacro";
              fg = "orange";
            };
            update = ["RecordingEnter" "RecordingLeave"];
            right_sep = " ";
          }
        ]

        [
          {
            provider = mkLuaInline ''
              function(component, opts)
                if vim.bo.filetype == "oil" then
                  local name = " Oil"
                  if vim.bo.modified then name = name .. " ●" end
                  return name
                end

                return file.file_info(component, file_info_opts)
              end
            '';
            update = ["BufEnter" "BufWritePost"];
          }
        ]

        [
          {
            provider = "diagnostic_errors";
            hl = {
              name = "StatusComponentDiagnosticErrors";
              fg = "red";
            };
          }
          {
            provider = "diagnostic_warnings";
            hl = {
              name = "StatusComponentDiagnosticWarnings";
              fg = "yellow";
            };
          }
          {
            provider = "diagnostic_hints";
            hl = {
              name = "StatusComponentDiagnosticHints";
              fg = "cyan";
            };
          }
          {
            provider = "diagnostic_info";
            hl = {
              name = "StatusComponentDiagnosticInfo";
              fg = "oceanblue";
            };
          }
          {
            provider = mkLuaInline ''
              function()
                return " " .. cursor.position(nil, {}) .. " "
              end
            '';
            hl = {
              name = "StatusComponentPosition";
              fg = "bg";
              bg = "green";
              style = "bold";
            };
            update = ["CursorMoved"];
            left_sep = " ";
          }
        ]
      ];
    };
  };
}
