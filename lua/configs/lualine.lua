-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

local navic = require('nvim-navic')

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local function vim_logo()
  return ''
end

local function close_char()
  return '󰱞'
end

local function lsp_attached()
  return #vim.lsp.get_clients({ bufnr = 0 }) > 0
end

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach' }, {
  group = vim.api.nvim_create_augroup('dephilia_lualine_lsp', { clear = true }),
  callback = function()
    require('lualine').refresh()
  end,
})

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'kanagawa',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = true,
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = trunc(90, 30, 60) },
      'diff',
      'diagnostics',
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available, fmt = trunc(90, 30, 80) },
    },
    lualine_x = {
      {
        function()
          return ''
        end,
        cond = lsp_attached,
      },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {},
    lualine_b = { vim_logo },
    lualine_c = { require('tabline').tabline_buffers },
    lualine_x = { require('tabline').tabline_tabs },
    lualine_y = { close_char },
    lualine_z = {},
  },
  extensions = {
    'nvim-tree',
    'quickfix',
    'fugitive',
  },
})
