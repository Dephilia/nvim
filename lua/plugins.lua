#! /usr/bin/env lua
--
-- plugins.lua
-- Copyright (C) 2022 Dephilia
--
-- Distributed under terms of the MIT license.
--

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('configs/lualine-config')
    end
  }
  use {
    'kdheepak/tabline.nvim',
    requires = {
      { 'hoob3rt/lualine.nvim' },
      { 'kyazdani42/nvim-web-devicons' }
    },
    config = function()
      require('configs/tabline-config')
    end
  }
  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('configs/dashboard')
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('configs/nvimtree')
    end,
    opt = true,
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' }
  }

  use {
    -- Do not use the bug v1
    'phaazon/hop.nvim',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use { 'aperezdc/vim-template' }
  use { 'junegunn/vim-easy-align' }
  use { 'ahonn/vim-fileheader' }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use { 'itchyny/vim-gitbranch' }
  use { 'psliwka/vim-smoothie' }
  use { 'godlygeek/tabular' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-fugitive' }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = " ",
      }
    end
  }
  use { 'vim-scripts/DoxygenToolkit.vim',
    opt = true,
    cmd = { 'Dox' }
  }
  use {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
      vim.notify = require("notify")
    end
  }
  use { 'sbdchd/neoformat',
    opt = true,
    cmd = { 'Neoformat' }
  }
  use {
    'skywind3000/asyncrun.vim',
    opt = true,
    cmd = { 'AsyncRun' },
    setup = function()
      vim.g['asyncrun_open'] = 8
    end
  }

  use { 'sheerun/vim-polyglot', opt = true }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('configs/treesitter')
    end
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }
  use {
    'p00f/nvim-ts-rainbow',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }
  use {
    'liuchengxu/vista.vim',
    opt = true,
    cmd = { 'Vista', 'Vista!!' }
  }
  use {
      'simrat39/symbols-outline.nvim',
      opt = true,
      cmd = { 'SymbolsOutline' },
      config = function()
	require("symbols-outline").setup()
      end
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer'
  }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp/setup')
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('lsp/nvim-cmp')
    end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'onsails/lspkind-nvim' },
    }
  }
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').init_lsp_saga()
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async'
  }

  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

  -- fzf, the fuzzy finder
  use {
    'junegunn/fzf.vim',
    requires = {
      {
        'junegunn/fzf',
        run = './install --bin'
      }
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  }

  -- -- Themes
  use { 'connorholyday/vim-snazzy' }
  use { 'shaunsingh/nord.nvim' }
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }
  use { 'folke/tokyonight.nvim' }
  use { 'rebelot/kanagawa.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
