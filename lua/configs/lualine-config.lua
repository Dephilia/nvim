#! /usr/bin/env lua
--
-- lualine-config.lua
-- Copyright (C) 2022 Dephilia
--
-- Distributed under terms of the MIT license.

---@diagnostic disable-next-line: unused-local
local snazzy = require('configs/snazzy')
local navic = require("nvim-navic")

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local function vim_logo()
  return "" -- \ue7c5
end

local function close_char()
  return "󰱞" -- \uf0c5e
end

require('lualine').setup {
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
      'diff', 'diagnostics'
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available, fmt = trunc(90, 30, 80) },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = { vim_logo },
    lualine_c = { require 'tabline'.tabline_buffers },
    lualine_x = { require 'tabline'.tabline_tabs },
    lualine_y = { close_char },
    lualine_z = {},
  },
  extensions = {
    'fzf',
    'nvim-tree',
    'symbols-outline',
    'quickfix',
    'fugitive'
  }
}
