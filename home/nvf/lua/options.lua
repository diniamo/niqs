local opt = vim.opt

opt.completeopt = "menu,menuone,noselect,preview"
opt.cursorline = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
-- TODO: figure this out
-- opt.formatoptions = "jqln"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
-- TODO: what should this be?
-- opt.sidescrolloff = 
opt.signcolumn = "yes"
-- This seems to break comments in nix
-- opt.smartindent = true
opt.spelllang = { "en", "hu" }
opt.spelloptions:append("noplainbuffer")
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.smoothscroll = true

vim.g.markdown_recommended_style = 0
