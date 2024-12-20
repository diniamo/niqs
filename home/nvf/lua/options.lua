vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.cinkeys:remove("0#")
vim.opt.indentkeys:remove("0#")
vim.opt.spelloptions:append("noplainbuffer")
