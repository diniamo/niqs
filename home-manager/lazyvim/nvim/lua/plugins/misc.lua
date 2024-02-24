return {
    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = "<C-t>",
            shade_terminals = false,
            direction = "float",
            -- Use background colored single border for padding

            float_opts = {
                border = "single",
            },
            highlights = {
                NormalFloat = {
                    guibg = "#24273a",
                },
                FloatBorder = {
                    guifg = "#24273a",
                    guibg = "#24273a",
                },
            },
        },
        keys = {
            "<C-t>",
            "<leader>gg",
            "<leader>gG",
        },
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "echasnovski/mini.pairs",
        enabled = false,
    },
    {
        "ZhiyuanLck/smart-pairs",
        -- Loading and enter mapping is handled in nvim-cmp, there is currently no edge case for if nvim-cmp isn't loaded, smart-pairs will simply not load
        -- Uncomment event, and comment lazy and opts if using without nvim-cmp for some reason
        -- event = "InsertEnter",
        lazy = true,
        opts = {
            enter = {
                enable_mapping = false,
            },
        },
        config = function(_, opts)
            require("pairs"):setup(opts)
        end,
    },
}
