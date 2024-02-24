-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- local api = vim.api

-- Workaround for #21856
-- api.nvim_create_autocmd({ "VimLeave" }, {
--   callback = function()
--     vim.cmd('!notify-send  ""')
--     vim.cmd("sleep 10m")
--   end,
-- })
-- api.nvim_create_autocmd({ "VimLeave" }, {
--   callback = function()
--     vim.fn.jobstart('notify-send ""', { detach = true })
--   end,
-- })

-- Remove padding in Neovim
-- vim.cmd([[
--   augroup kitty_padding
--     autocmd!
--     au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=5
--     au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
--   augroup END
-- ]])
