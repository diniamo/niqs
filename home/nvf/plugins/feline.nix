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

      disable.buftypes = [
        "^nofile$"
        "^terminal$"
        "^help$"
      ];

      custom_providers = {
        padded_vi_mode = mkLuaInline ''
          function()
            return " " .. vi_mode.get_vim_mode() .. " "
          end
        '';

        visual_count = mkLuaInline ''
          function()
            local mode = vim.fn.mode()
            if mode == "v" then
              local start_line = vim.fn.line("v")
              local end_line = vim.fn.line(".")

              if start_line == end_line then
                return tostring(math.abs(vim.fn.virtcol(".") - vim.fn.virtcol("v")) + 1)
              else
                return tostring(math.abs(end_line - start_line) + 1)
              end
            elseif mode == "V" then
              return tostring(math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1)
            elseif mode == "" then
              return math.abs(vim.fn.virtcol(".") - vim.fn.virtcol("v")) + 1 .. "x" .. math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1
            else
              return ""
            end
          end
        '';

        extended_file_info = mkLuaInline ''
          function(component)
            if vim.bo.filetype == "oil" then
              local name = " Oil"
              if vim.bo.modified then name = name .. " ●" end
              return name
            end

            return file.file_info(component, file_info_opts)
          end
        '';

        padded_position = mkLuaInline ''
          function()
            return " " .. cursor.position(nil, {}) .. " "
          end
        '';
      };

      components.active = [
        [
          {
            provider = {
              name = "padded_vi_mode";
              update = ["ModeChanged"];
            };
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
          {
            provider = {
              name = "visual_count";
              update = ["ModeChanged" "CursorMoved"];
            };
            hl = {
              name = "StatusComponentVisualCount";
              fg = "violet";
            };
            right_sep = " ";
          }
        ]

        [
          {
            provider = {
              name = "extended_file_info";
              update = ["BufEnter" "BufModifiedSet"];
            };
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
            provider = {
              name = "padded_position";
              update = ["CursorMoved" "CursorMovedI"];
            };
            hl = {
              name = "StatusComponentPosition";
              fg = "bg";
              bg = "green";
              style = "bold";
            };
            left_sep = " ";
          }
        ]
      ];
    };
  };
}
