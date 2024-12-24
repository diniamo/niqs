-- TODO: move these to nix once a better way to deal with modes is implemented in nvf

local map = function(mode, lhs, rhs, opts)
    opts.noremap = true
    opts.silent = true
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Use screen lines for movement if we are only moving one line
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move lines down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move lines up" })

-- Restore selection after visual indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { desc = "Next search result", expr = true })
map("x", "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true })
map("o", "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { desc = "Prev search result", expr = true })
map("x", "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true })
map("o", "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true })

-- Window movement
map({ "n", "t" }, "<C-h>", "<C-w>h", { desc = "Go to left window" })
map({ "n", "t" }, "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map({ "n", "t" }, "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map({ "n", "t" }, "<C-l>", "<C-w>l", { desc = "Go to right window" })

map({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Word deletions
map("i", "<C-BS>", "<C-w>", { desc = "Delete word behind" })
map("i", "<C-Del>", "<C-o>de", { desc = "Delete word in front" })

-- Normal mode enter
map("n", "<CR>", "o<esc>", { desc = "Insert line below" })
map("n", "<S-CR>", "O<esc>", { desc = "Insert line above" })

-- Breakpoints
map("i", ",", ",<C-g>u", { desc = "Insert undo breakpoint after ," })
map("i", ".", ".<C-g>u", { desc = "Insert undo breakpoint after ." })
map("i", ";", ";<C-g>u", { desc = "Insert undo breakpoint after ;" })

-- Comment
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- Misc
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>silent w<cr><esc>", { desc = "Save file" })
map("n", "<C-,>", "mtA;<esc>`t", { desc = "Append ; to the end of the line" })

map({ "n", "t" }, "<C-q>", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("modified", { buf = buf }) then
      vim.api.nvim_win_set_buf(0, buf)
      vim.notify("Unsaved changes")
      return
    end
  end

  vim.cmd("quitall")
end, { desc = "Jump to unsaved buffer or quit" })

map("n", "<leader>jp", function()
  local keyword = vim.fn.input("Keyword: ")
  if keyword == "" then return end

  local directory = vim.fn.system({ "zoxide", "query", keyword }):match("(.*)[\n\r]")
  if directory == "zoxide: no match found" then
    vim.notify("No match found", vim.log.levels.ERROR)
  else
    vim.fn.chdir(directory)
    vim.notify(directory)
  end
end, { desc = "Zoxide prompt" })

map("n", "<C-c>", function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '"')
end, { desc = "Copy file path to system clipboard" })
