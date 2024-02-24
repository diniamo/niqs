return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                require("catppuccin").load("macchiato")
            end,

            news = {
                neovim = true,
            },
        },
    },
    {
        "folke/noice.nvim",
        opts = {
            presets = {
                bottom_search = false,
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "4" },
                },
            },
        },
        init = function()
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    vim.b.autoformat = false
                else
                    vim.g.autoformat = false
                end
            end, { desc = "Disable autoformat-on-save", bang = true })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.autoformat = true
                vim.g.autoformat = true
            end, { desc = "Enable autoformat-on-save" })
        end,
    },
    {
        "nvimdev/dashboard-nvim",
        opts = function(_, opts)
            local utils = require("utils")

            utils.insertMultipleAtPosition(opts.config.center, 5, {
                action = utils.inputZoxide,
                desc = " Zoxide Jump",
                icon = " ",
                key = "z",
                key_format = "  %s",
            }, {
                action = "Telescope zoxide list",
                desc = " Zoxide List",
                icon = " ",
                key = "i",
                key_format = "  %s",
            })

            return opts
        end,
    },
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                search = {
                    enabled = false
                }
            }
        }
    }
}
