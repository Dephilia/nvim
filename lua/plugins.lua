#! /usr/bin/env lua
--
-- plugins.lua
-- Copyright (C) 2022 Dephilia
--
-- Distributed under terms of the MIT license.
--

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    config = function()
      require('configs/lualine-config')
    end
  },
  {
    'kdheepak/tabline.nvim',
    dependencies = {
      'nvim-lualine/lualine.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require('configs/tabline-config')
    end
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('configs/nvimtree')
    end,
    lazy = true,
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' }
  },

  {
    'phaazon/hop.nvim',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
  'aperezdc/vim-template',
  'junegunn/vim-easy-align',
  'ahonn/vim-fileheader',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  'itchyny/vim-gitbranch',
  'godlygeek/tabular',
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  },
  'tpope/vim-fugitive',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
    config = function()
	require("ibl").setup()
    end,
    cmd = { 'IBLDisable', 'IBLEnable', 'IBLToggle' }
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
      vim.notify = require("notify")
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('configs/treesitter')
    end
  },
  {
      'simrat39/symbols-outline.nvim',
      lazy = true,
      cmd = { 'SymbolsOutline' },
      config = function()
	require("symbols-outline").setup()
      end
  },

  -- LSP
  'nvimtools/none-ls.nvim',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp/setup')
    end
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('lsp/nvim-cmp')
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind-nvim',
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  },

  -- -- Themes
  'connorholyday/vim-snazzy',
  'rebelot/kanagawa.nvim',
}
