" (c) 2022 Dephilia
" MIT license (See LICENSE for details)

if !has('nvim-0.8.0')
  echohl Error | echomsg "Nvim 0.8.0 required, but is missing!" | echohl None
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
      \ 'lua_ls',
      \ 'rust_analyzer',
      \ 'bashls',
      \ 'html',
      \ 'tsserver',
      \ ]

set termguicolors

" Load Plug
" Description: Load the plugins by the provider.
"=============================="
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
EOF

" Post Configuration
" Description: The settings will load after plugins
"=============================="
runtime vim/utils.vim

" Relativenumber hook
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
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
nmap <silent> <Leader>t  :SymbolsOutline<CR>
nmap <silent> <Leader>n  :NvimTreeToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <Leader><Leader><Leader> <cmd>Telescope <cr>
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

" Quickfix mapping
nnoremap <silent> <F2> :call utils#toggle_quickfix()<CR>

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

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>

" LSP mappings
" Ref to lua/lsp/setup.lua
"    and lua/lsp/nvim-cmp.lua
" Note here to prevent from forgetting the settings

" utils
nmap <silent> <Leader>B :call utils#toggle_bracket_mode() <CR>

" hidden char
nmap <silent> <Leader>h :set list! <CR>
nmap <silent> <Leader>H :call utils#cleanmode_toggle() <CR>

" Default colorsheme
" Description: Use kanagawa default
"=============================="
colorscheme kanagawa

" Syntax Enable
" Description: Enable syntax default
"=============================="
syntax enable

" Vim settings
" Description: The vim's settings
"=============================="
set background=dark " background
set encoding=UTF-8  " coding
set showtabline=2   " Tabline
set laststatus=2    " Statusbar
set noshowmode      " hide the -- INSERT --
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

" Tab
set noexpandtab    " Use tab
set tabstop=8      " Tab width. Default 8
set shiftwidth=4   " Input tab width.
set softtabstop=-1 " Follow shiftwidth setting

" Show hide chars
set list listchars+=tab:→\ 
set list listchars+=space:·
set list listchars+=nbsp:␣
set list listchars+=trail:•
set list listchars+=eol:¶
set list listchars+=precedes:«
set list listchars+=extends:»
set nolist " Default disable

" Folding
set foldenable
set foldlevel=99
set fillchars+=fold:\ ,foldopen:,foldsep:\ ,foldclose:

" END
"=============================="
