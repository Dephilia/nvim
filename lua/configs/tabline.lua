-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

require('tabline').setup({
  enable = false,
  options = {
    component_separators = { '|', '|' },
    section_separators = { '', '' },
    max_bufferline_percent = 66,
    show_tabs_always = true,
    show_devicons = true,
    show_bufnr = true,
    show_filename_only = true,
    modified_icon = '+ ',
    modified_italic = false,
    show_tabs_only = false,
  },
})
