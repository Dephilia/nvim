-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = augroup('dephilia_numbertoggle', { clear = true }),
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= 'i' then
      vim.wo.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = 'dephilia_numbertoggle',
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

autocmd('ColorScheme', {
  group = augroup('dephilia_highlights', { clear = true }),
  callback = function()
    vim.cmd('highlight CursorLine term=bold cterm=bold')
  end,
})

-- Neovim 0.12 auto-starts bundled treesitter for lua/markdown/help/query.
-- This config uses syntax + LSP semantic tokens instead.
autocmd('FileType', {
  group = augroup('dephilia_no_ts', { clear = true }),
  callback = function(ev)
    vim.schedule(function()
      pcall(vim.treesitter.stop, ev.buf)
    end)
  end,
})
