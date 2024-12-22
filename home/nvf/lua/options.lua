local opt = vim.opt

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " "
}
opt.listchars = {
  tab = "→ ",
  trail = "·"
}
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.cinkeys:remove("0#")
opt.indentkeys:remove("0#")
opt.spelloptions:append("noplainbuffer")
