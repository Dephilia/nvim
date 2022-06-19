" @Author: Dephilia <me@dephilia.moe>
" @Date: 2019-10-17 23:45:54
" @Last Modified by: Dephilia <me@dephilia.moe>
" @Last Modified time: 2022-06-19 22:41:37

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

let g:rainbow_active = 1
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
  autocmd FileType dashboard setlocal fillchars+=eob:\ 
  autocmd FileType dashboard setlocal noru
augroup END

" Auto change lualine theme
augroup colorsheme_chain
  autocmd!
  autocmd ColorScheme snazzy     lua require('lualine').setup { options = { theme = require('configs/snazzy') }}
  autocmd ColorScheme nord       lua require('lualine').setup { options = { theme = 'nord'                    }}
  autocmd ColorScheme catppuccin lua require('lualine').setup { options = { theme = 'catppuccin'              }}
  autocmd ColorScheme tokyonight lua require('lualine').setup { options = { theme = 'tokyonight'              }}
augroup END

" Fix telescope will make ts folding expr unusable
" Delete this until telescope fix the bug
" Follow https://github.com/nvim-telescope/telescope.nvim/issues/699
augroup telescope_fix_folding
  autocmd!
  autocmd BufEnter * normal! zx " Update folding expr
  autocmd BufEnter * normal! zR " And open all folding
augroup END

" Conflict to fugitive, not use now
" augroup non_utf8_file_warn
"   autocmd!
"   autocmd BufRead * if &fileencoding != 'utf-8' |
"         \ call v:lua.vim.notify("File is not in UTF-8 format!", "warn", {"title": "File type warning"}) |
"         \ endif
" augroup END

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

" lspsaga
nnoremap <silent> gh :Lspsaga lsp_finder<CR>

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
set cmdheight=2     " Higher cmd line
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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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
