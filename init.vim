" @Author: Dephilia <me@dephilia.moe>
" @Date: 2019-10-17 23:45:54
" @Last Modified by: Dephilia <me@dephilia.moe>
" @Last Modified time: 2022-06-21 22:50:16

if !has('nvim-0.7.0')
  echohl Error | echomsg "Nvim 0.7.0 required, but is missing!" | echohl None
  finish
endif

" Pre Plug Configuration
" Description: Some settings need to be configured
"   before load it.
"=============================="
let mapleader = ","

let g:treesitter_langs = [ 
      \ 'bash',
      \ 'c',
      \ 'cpp',
      \ 'cmake',
      \ 'html',
      \ 'javascript',
      \ 'json',
      \ 'make',
      \ 'python',
      \ 'lua',
      \ 'rust',
      \ 'toml',
      \ 'yaml',
      \ 'vim',
      \ ]
let g:lsp_servers = [
      \ 'pyright',
      \ 'clangd',
      \ 'sumneko_lua',
      \ 'rust_analyzer',
      \ 'bashls',
      \ 'html',
      \ 'tsserver',
      \ ]

set termguicolors

" Load Plug
" Description: Load the plugins by the provider. Default: packer
"=============================="
lua require('plugins')

" Post Configuration
" Description: The settings will load after plugins
"=============================="
runtime vim/utils.vim
runtime vim/cscfg.vim

" Disable default. Enable it for smoooothie scroll
let g:smoothie_enabled = 0

" Theme settings
let g:SnazzyTransparent = 1
let g:tokyonight_style = "night"

" Auto command
" Description: Auto commands
"=============================="
augroup dashboard_cfg
  autocmd!
  autocmd FileType dashboard nnoremap <buffer> <silent> <Leader>fm :Telescope marks<CR>
  autocmd FileType dashboard nnoremap <buffer> <silent> <Leader>bo :DashboardNewFile<CR>

  " hide tilde
  autocmd FileType dashboard setlocal noru
augroup END

augroup clean_tools
  autocmd!
  autocmd FileType dashboard,qf,Outline,vista
        \ setlocal fillchars+=eob:\  |
        \ setlocal norelativenumber  |
        \ setlocal nonumber          |
        \ setlocal nolist            |
  autocmd BufEnter NvimTree_*
        \ setlocal fillchars+=eob:\  |
        \ setlocal norelativenumber  |
        \ setlocal nonumber          |
        \ setlocal nolist            |
augroup END

" Auto change lualine theme
augroup colorsheme_chain
  autocmd!
  autocmd ColorScheme snazzy     lua require('lualine').setup { options = { theme = require('configs/snazzy') }}
  autocmd ColorScheme nord       lua require('lualine').setup { options = { theme = 'nord'                    }}
  autocmd ColorScheme catppuccin lua require('lualine').setup { options = { theme = 'catppuccin'              }}
  autocmd ColorScheme tokyonight lua require('lualine').setup { options = { theme = 'tokyonight'              }}
augroup END

" Treesitter folding. nvim_treesitter#foldexpr() can only called after load
" the plugin configuration.
augroup ts_folding
  autocmd!
  autocmd BufEnter * setl foldexpr=nvim_treesitter#foldexpr()
augroup END

" Hightlight
" Description: Hightlights
"=============================="
hi CursorLine term=bold cterm=bold

" Key mapping
" Description: The key mappings :)
"=============================="
" jj escape
inoremap <silent> jj <ESC>

" use arrow key
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Plug mapping
nmap <silent> <Leader>vv :Vista!!<CR>
nmap <silent> <Leader>t  :SymbolsOutline<CR>
nmap <silent> <Leader>n  :NvimTreeToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <Leader>ft <cmd>Telescope <cr>
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>

" tabline mapping
nmap <silent> <C-h> :bprevious<CR>
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <Leader><C-h> :tabprevious<CR>
nmap <silent> <Leader><C-l> :tabnext<CR>

" Buffer mapping
" 1. List buffer
nnoremap <silent> bl :ls<CR>
" 2. New empty buffer
nnoremap <silent> bo :enew<CR>
" 3. Next buffer
nnoremap <silent> bn :bnext<CR>
" 4. Previous buffer
nnoremap <silent> bp :bprevious<CR>
" 5. Close buffer
nnoremap <silent> bd :bdelete<CR>

" easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

nmap <silent> <Leader><C-r> <cmd> so $MYVIMRC <bar>
  \ call v:lua.vim.notify("Reload Config", "info", {'title': 'neovim config'}) <CR>

" copy to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" hop.nvim
nmap <Leader>e <cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>
vmap <Leader>e <cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>
omap <Leader>e <cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>

" LSP mappings
" Ref to lua/lsp/setup.lua
"    and lua/lsp/nvim-cmp.lua
" Note here to prevent from forgetting the settings

" cscope mappings
" See vim/cscfg.vim

" utils
nmap <silent> <Leader>B :call utils#toggle_bracket_mode() <CR>

" hidden char
nmap <silent> <Leader>H :set list! <CR>

" Default colorsheme
" Description: Use snazzy default
"=============================="
colorscheme snazzy

" Syntax Enable
" Description: Enable syntax default
"=============================="
syntax enable

" Vim settings
" Description: The vim's settings
"=============================="
set background=dark " background
set encoding=UTF-8  " coding
set expandtab       " <tab> as many <space>
set tabstop=2       " width of tab
set showtabline=2   " Tabline
set laststatus=2    " Statusbar
set noshowmode      " hide the -- INSERT --
set shiftwidth=2    " indent width
set softtabstop=2   " how many space insert after press tab
set cmdheight=1     " Higher cmd line (Set to 1 because notify.nvim)
set autoindent      " auto indent next line
set smartindent     " smart indent
set incsearch       " inc search
set ignorecase      " ignore case
set hlsearch        " search high light
set relativenumber  " show relative line number
set number          " show line number
set cursorline      " highlight current line
set hidden          " Hide edited buffer
set updatetime=300  " Short update time
set shortmess+=c    " Supress ins-completion msg
set tags=./tags,./TAGS,tags;~,TAGS;~ " Tags location

" Show hide chars
set list listchars+=tab:→\ 
set list listchars+=space:·
set list listchars+=nbsp:␣
set list listchars+=trail:•
set list listchars+=eol:¶
set list listchars+=precedes:«
set list listchars+=extends:»

" Folding
set foldlevel=99
set foldmethod=expr

" GUI Settings
" Description: Only for GUI
"=============================="
if has('gui_running')
  set guifont=Mononoki\ Nerd\ Font\ mono:h14
endif
if exists('g:neovide')
  set guifont=Mononoki\ Nerd\ Font\ mono:h14
  let g:neovide_transparency=0.9
  let g:neovide_cursor_vfx_mode='railgun'
endif

" END
"=============================="
