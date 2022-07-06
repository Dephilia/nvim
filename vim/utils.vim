" Auto add bracket
let s:AutoBracketEnable = 0
let s:CleanModeEnable = 0

function! utils#toggle_bracket_mode()
    if s:AutoBracketEnable
        iunmap {
        iunmap {<Enter>
        iunmap (
        iunmap (<Enter>
        iunmap '
        iunmap "
        let s:AutoBracketEnable = 0
        call v:lua.vim.notify("Disable Auto Bracket", "info", {'title': 'neovim utils'})
    else
        inoremap { {}<Left>
        inoremap {<Enter> {}<Left><CR><ESC><S-o>
        inoremap ( ()<ESC>i
        inoremap (<Enter> ()<Left><CR><ESC><S-o>
        inoremap ' ''<LEFT>
        inoremap " ""<LEFT>
        let s:AutoBracketEnable = 1
        call v:lua.vim.notify("Enable Auto Bracket", "info", {'title': 'neovim utils'})
    endif
endfunction

" Cleanmode -> Toggle hidden char to be visible
function! utils#cleanmode_enable()
  set norelativenumber
  set nonumber
  set nolist
  lua require("indent_blankline.commands").disable("<bang>" == "!")
  lua package.loaded.gitsigns.detach()
  call v:lua.vim.notify("Enable Clean Mode", "info", {'title': 'neovim utils'})
  let s:CleanModeEnable = 1
endfunction
command! -nargs=0 CleanModeEnable :call utils#cleanmode_enable()

function! utils#cleanmode_disable()
  set relativenumber
  set number
  set list
  let g:indentLine_enabled = v:true
  lua require("indent_blankline.commands").enable("<bang>" == "!")
  lua package.loaded.gitsigns.attach()
  call v:lua.vim.notify("Disable Clean Mode", "info", {'title': 'neovim utils'})
  let s:CleanModeEnable = 0
endfunction
command! -nargs=0 CleanModeDisable :call utils#cleanmode_disable()

function! utils#cleanmode_toggle()
    if s:CleanModeEnable
	call utils#cleanmode_disable()
    else
	call utils#cleanmode_enable()
    endif
endfunction
command! -nargs=0 CleanModeToggle :call utils#cleanmode_toggle()


" Hex Modified
function! utils#hexmode_enable()
  if !executable('xxd')
    echo "xxd not installed."
    return
  endif
  set ft=xxd
  set binary
  set noeol
  execute('%!xxd')
  call v:lua.vim.notify("Enable Hex Mode\nCall :HexModeDisable before save file.", "info", {'title': 'neovim utils'})
endfunction
command! -nargs=0 HexModeEnable :call utils#hexmode_enable()

function! utils#hexmode_disable()
  if !executable('xxd')
    echo "xxd not installed."
    return
  endif
  execute('%!xxd -r')
  set ft&
  set eol
  call v:lua.vim.notify("Disable Hex Mode", "info", {'title': 'neovim utils'})
endfunction
command! -nargs=0 HexModeDisable :call utils#hexmode_disable()

" Clear Additional Space
command! -nargs=0 ClearSpaces :%s/\s\+$//e

function! utils#toggle_quickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
