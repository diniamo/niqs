-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local unmap = vim.keymap.del
local Util = require("lazyvim.util")

-- <C-H> is <C-BS> in wezterm
map("i", "<C-BS>", "<C-w>")
map("i", "<C-Del>", "<C-o>de")

map("n", "<CR>", "o<ESC>")
map("n", "<S-CR>", "O<ESC>")
map("n", "<C-A>", "ggVG")

unmap("n", "<S-h>")
unmap("n", "<S-l>")
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")

map("n", "<leader>;", function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd(":normal A;")
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "Appends a ; to the current line" })

map("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return '"_cc'
  else
    return "i"
  end
end, { expr = true, desc = "Properly indent when entering insert mode" })

-- Terminals
local terminals = {}
local function toggle_terminal(name, term)
  local terminal = terminals[name]
  if not terminal then
    terminal = require("toggleterm.terminal").Terminal:new(term)
    terminals[name] = terminal
  end

  terminal:toggle()
end

map("n", "<leader>gg", function()
  toggle_terminal("lazygit_root", { cmd = "lazygit", dir = Util.root(), hidden = true })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  toggle_terminal("lazygit_cwd", { cmd = "lazygit", hidden = true })
end, { desc = "Lazygit (cwd)" })
