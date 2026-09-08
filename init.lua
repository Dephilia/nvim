-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

if vim.fn.has('nvim-0.12') == 0 then
  vim.api.nvim_echo({ { 'Nvim 0.12+ required', 'ErrorMsg' } }, true, {})
  return
end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

require('dephilia.options')
require('dephilia.autocmds')
require('dephilia.pack')
require('dephilia.lsp')
require('dephilia.keymaps')
require('dephilia.utils')
