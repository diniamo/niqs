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

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { desc = "Next search result", expr = true })
map("x", "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true })
map("o", "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { desc = "Prev search result", expr = true })
map("x", "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true })
map("o", "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>silent w<cr><esc>", { desc = "Save file" })

-- Window movement
map({ "n", "t" }, "<C-h>", "<C-w>h", { desc = "Go to left window" })
map({ "n", "t" }, "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map({ "n", "t" }, "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map({ "n", "t" }, "<C-l>", "<C-w>l", { desc = "Go to right window" })

map({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
