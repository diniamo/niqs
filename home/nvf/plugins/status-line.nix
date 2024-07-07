{
  programs.nvf.settings.vim.ui.breadcrumbs.enable = true;

  programs.nvf.settings.vim.statusline = {
    lualine = {
      enable = true;
      componentSeparator = {
        left = "";
        right = "";
      };
      sectionSeparator = {
        left = "";
        right = "";
      };

      # setupOpts.winbar.lualine_c = mkForce [];
      activeSection = {
        a = ["'mode'"];
        b = [
          ''
            {
              "filetype",
              icon_only = true
            }
          ''
          ''
            {
              "filename",
              symbols = { modified = ' ', readonly = ' ' }
            }
          ''
        ];
        c = ["'navic'"];
        x = [
          ''
            {
              function() return " " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = 'Debug'
            }
          ''
          ''
            {
              "diagnostics",
              sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp'},
              symbols = {error = '󰅙 ', warn = ' ', info = ' ', hint = '󰌵 '},
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = { fg = 'red' },
                color_warn = { fg = 'yellow' },
                color_info = { fg = 'cyan' },
              }
            }
          ''
          ''
            {
              function()
                local clients = vim.lsp.get_active_clients()

                if next(clients) == nil then
                  return "No LSP"
                end

                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1 then
                    return client.name
                  end
                end

                return "No LSP"
              end,
              cond = function()
                return vim.fn.index({"toggleterm", "NvimTree", "TelescopePrompt"}, vim.bo.filetype) == -1
              end,
              icon = ''
            }
          ''
        ];
        y = [
          ''
            {
              function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                color = { fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = 'Constant' }).fg) }
            }
          ''
          ''
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = { fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = 'Statement' }).fg) }
            }
          ''
          "'location'"
        ];
        z = ["{ function() return os.date(' %R') end }"];
      };
    };
  };
}
