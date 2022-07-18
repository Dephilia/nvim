#! /usr/bin/env lua
--
-- dashboard.lua
-- Copyright (C) 2022 Dephilia
--
-- Distributed under terms of the MIT license.
--

local header = {
  '',
  '',
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '  -- Dephilia\'s Configuration                         ',
  '',
  '',
}

local db = require('dashboard')
db.custom_header = header
db.custom_center = {
  {
    icon = '  ',
    desc = 'New file                                 ',
    action = 'DashboardNewFile',
    shortcut = '<leader> b o',
  },
  {
    icon = '  ',
    desc = 'Find File                                ',
    action = 'Telescope find_files hidden=true no_ignore=true',
    shortcut = '<leader> f f',
  },
  {
    icon = '  ',
    desc = 'Marks                                    ',
    action = 'Telescope marks',
    shortcut = '<leader> f m'
  },
  {
    icon = '  ',
    desc = 'Find word                                ',
    action = 'Telescope live_grep',
    shortcut = '<leader> f g',
  },
  {
    icon = '  ',
    desc = 'Update Plugins                           ',
    action = 'PackerSync',
    shortcut = ':PackerSync ',
  },
  {
    icon = '  ',
    desc = 'Close Neovim                             ',
    action = 'qa!',
    shortcut = ':qa!        ',
  },
}

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#A0E7E5' })
vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#FFAEBC' })
vim.api.nvim_set_hl(0, 'DashboardCenterIcon', { fg = '#B4F8C8' })
vim.api.nvim_set_hl(0, 'DashboardShortCut', { fg = '#FBE7C6' })
vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = 'lightgrey' })
