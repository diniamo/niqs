return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
    init = function()
      local telescope = require("telescope")
      local map = vim.keymap.set

      telescope.load_extension("zoxide")
      map("n", "<leader>zi", telescope.extensions.zoxide.list)
      map("n", "<leader>zz", require("utils").inputZoxide)
    end,
    keys = {
      "<leader>zz",
      "<leader>zi",
    },
  },
}
