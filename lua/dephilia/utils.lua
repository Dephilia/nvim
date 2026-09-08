-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

local M = {}

local auto_bracket = false
local clean_mode = false

local function notify(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = 'neovim utils' })
end

function M.toggle_bracket_mode()
  if auto_bracket then
    vim.keymap.del('i', '{')
    vim.keymap.del('i', '{<CR>')
    vim.keymap.del('i', '(')
    vim.keymap.del('i', '(<CR>')
    vim.keymap.del('i', "'")
    vim.keymap.del('i', '"')
    auto_bracket = false
    notify('Disable Auto Bracket')
  else
    vim.keymap.set('i', '{', '{}<Left>')
    vim.keymap.set('i', '{<CR>', '{}<Left><CR><Esc><S-o>')
    vim.keymap.set('i', '(', '()<Esc>i')
    vim.keymap.set('i', '(<CR>', '()<Left><CR><Esc><S-o>')
    vim.keymap.set('i', "'", "''<Left>")
    vim.keymap.set('i', '"', '""<Left>')
    auto_bracket = true
    notify('Enable Auto Bracket')
  end
end

function M.cleanmode_enable()
  vim.opt.relativenumber = false
  vim.opt.number = false
  vim.opt.list = false
  pcall(vim.cmd.IBLDisable)
  pcall(function()
    require('gitsigns').detach()
  end)
  notify('Enable Clean Mode')
  clean_mode = true
end

function M.cleanmode_disable()
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.list = true
  pcall(vim.cmd.IBLEnable)
  pcall(function()
    require('gitsigns').attach()
  end)
  notify('Disable Clean Mode')
  clean_mode = false
end

function M.cleanmode_toggle()
  if clean_mode then
    M.cleanmode_disable()
  else
    M.cleanmode_enable()
  end
end

function M.toggle_quickfix()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd.cclose()
      notify('Quickfix closed')
      return
    end
  end
  vim.cmd.copen()
  if vim.tbl_isempty(vim.fn.getqflist()) then
    notify('Quickfix opened (empty)')
  else
    notify('Quickfix opened')
  end
end

vim.api.nvim_create_user_command('CleanModeEnable', M.cleanmode_enable, { desc = 'Hide numbers, listchars, indent guides, git signs' })
vim.api.nvim_create_user_command('CleanModeDisable', M.cleanmode_disable, { desc = 'Restore numbers, listchars, indent guides, git signs' })
vim.api.nvim_create_user_command('CleanModeToggle', M.cleanmode_toggle, { desc = 'Toggle clean mode' })
vim.api.nvim_create_user_command('ClearSpaces', '%s/\\s\\+$//e', { desc = 'Strip trailing whitespace' })

return M
