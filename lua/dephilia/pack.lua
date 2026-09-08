-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add({
  gh('nvim-tree/nvim-web-devicons'),
  gh('nvim-lua/plenary.nvim'),
  gh('rebelot/kanagawa.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('kdheepak/tabline.nvim'),
  gh('nvim-tree/nvim-tree.lua'),
  gh('smoka7/hop.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('tpope/vim-fugitive'),
  gh('lukas-reineke/indent-blankline.nvim'),
  gh('rcarriga/nvim-notify'),
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('saghen/blink.lib'),
  gh('saghen/blink.cmp'),
  gh('rafamadriz/friendly-snippets'),
  gh('folke/trouble.nvim'),
  gh('SmiteshP/nvim-navic'),
  gh('hedyhli/outline.nvim'),
  gh('nvim-telescope/telescope.nvim'),
})

require('notify').setup({
  background_colour = '#000000',
})
vim.notify = require('notify')

require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
require('gitsigns').setup()
require('ibl').setup()
require('outline').setup()
require('trouble').setup()
require('telescope').setup()

require('blink.cmp').setup({
  keymap = {
    preset = 'enter',
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
  },
  completion = {
    documentation = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = false } },
  },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
})

require('configs.nvimtree')
require('configs.tabline')
require('configs.lualine')

vim.cmd.colorscheme('kanagawa')
vim.cmd.syntax('enable')
