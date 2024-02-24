return {
    {
        {
            "epwalsh/obsidian.nvim",
            ft = "markdown",
            opts = {
                ui = { enable = false },
                workspaces = {
                    {
                        name = "Notes",
                        path = "~/Documents/Notes",
                    },
                },
                attachments = {
                    img_folder = "Attachments",
                },
                disable_frontmatter = true
            },
            init = function()
                vim.opt.linebreak = true
            end
        },
    },
}
