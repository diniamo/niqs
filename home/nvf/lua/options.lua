vim.o.cursorline = true
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.o.foldlevel = 99
-- TODO: figure this out
-- vim.o.formatoptions = "jqln"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.list = true
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.o.shiftround = true
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.o.showmode = false
vim.o.sidescrolloff = 2
vim.o.cindent = true
vim.opt.cinkeys:remove("0#")
vim.opt.indentkeys:remove("0#")
vim.opt.spelloptions:append("noplainbuffer")
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.virtualedit = "block"
vim.o.wildmode = "longest:full,full"
vim.o.winminwidth = 5
vim.o.wrap = false
vim.o.smoothscroll = true
vim.o.gdefault = true

vim.g.markdown_recommended_style = 0
