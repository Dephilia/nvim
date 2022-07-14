#! /usr/bin/env lua
--
-- nvimtree.lua
-- Copyright (C) 2022 Dephilia
--
-- Distributed under terms of the MIT license.
--

require 'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = false,
    }
  }
}
