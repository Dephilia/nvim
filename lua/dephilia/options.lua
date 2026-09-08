-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)
-- Only options that differ from Neovim 0.12 defaults.

local o = vim.opt

o.termguicolors = true
o.background = 'dark'
o.showtabline = 2
o.laststatus = 3
o.showmode = false
o.smartindent = true
o.ignorecase = true
o.relativenumber = true
o.number = true
o.cursorline = true
o.updatetime = 300
o.shortmess:append('c')
o.winborder = 'rounded'

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4

o.listchars = {
  tab = '→ ',
  space = '·',
  nbsp = '␣',
  trail = '•',
  eol = '¶',
  precedes = '«',
  extends = '»',
}

o.foldlevel = 99
o.fillchars:append({
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
})

o.sessionoptions:append('tabpages')
o.sessionoptions:append('globals')
