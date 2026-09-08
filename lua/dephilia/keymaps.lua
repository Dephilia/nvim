-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map('i', 'jj', '<Esc>', 'Escape insert')

map('n', '<Leader>t', '<cmd>Outline<CR>', 'Toggle symbol outline')
map('n', '<Leader>n', '<cmd>NvimTreeToggle<CR>', 'Toggle file tree')

map('n', '<Leader><Leader><Leader>', '<cmd>Telescope<CR>', 'Telescope')
map('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', 'Find files')
map('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', 'Live grep')
map('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', 'Find buffers')
map('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', 'Help tags')

map('n', '<C-h>', '<cmd>bprevious<CR>', 'Previous buffer')
map('n', '<C-l>', '<cmd>bnext<CR>', 'Next buffer')
map('n', '<Leader><C-h>', '<cmd>tabprevious<CR>', 'Previous tab')
map('n', '<Leader><C-l>', '<cmd>tabnext<CR>', 'Next tab')

map('n', 'bo', '<cmd>enew<CR>', 'New empty buffer')
map('n', 'bd', '<cmd>bdelete<CR>', 'Delete buffer')

map('n', '<F2>', function()
  require('dephilia.utils').toggle_quickfix()
end, 'Toggle quickfix')

map('n', '<Leader><C-r>', function()
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify('Reload Config', vim.log.levels.INFO, { title = 'neovim config' })
end, 'Reload config')

map({ 'n', 'v' }, '<Leader>y', '"*y', 'Yank to selection clipboard')
map({ 'n', 'v' }, '<Leader>p', '"*p', 'Paste selection clipboard')
map({ 'n', 'v' }, '<Leader>Y', '"+y', 'Yank to system clipboard')
map({ 'n', 'v' }, '<Leader>P', '"+p', 'Paste system clipboard')

map({ 'n', 'v', 'o' }, '<Leader>e', function()
  require('hop').hint_words({
    hint_position = require('hop.hint').HintPosition.END,
  })
end, 'Hop to word end')

map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', 'Trouble diagnostics')
map('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', 'Trouble buffer diagnostics')
map('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>', 'Trouble quickfix')
map('n', '<leader>xl', '<cmd>Trouble loclist toggle<CR>', 'Trouble loclist')
map('n', 'gr', '<cmd>Trouble lsp_references toggle<CR>', 'Trouble LSP references')

map('n', '<space>e', vim.diagnostic.open_float, 'Diagnostic float')
map('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, 'Previous diagnostic')
map('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, 'Next diagnostic')

map('n', '<Leader>B', function()
  require('dephilia.utils').toggle_bracket_mode()
end, 'Toggle auto-brackets')
map('n', '<Leader>h', '<cmd>set list!<CR>', 'Toggle listchars')
map('n', '<Leader>H', function()
  require('dephilia.utils').cleanmode_toggle()
end, 'Toggle clean mode')
