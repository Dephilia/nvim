" Auto add bracket
let s:AutoBracketEnable = 0

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

" Copymode -> Toggle hidden char to be visible
function! utils#copymode_enable()
  set norelativenumber
  set nonumber
  set nolist
  call gitgutter#disable()
  call v:lua.vim.notify("Enable Copy Mode", "info", {'title': 'neovim utils'})
endfunction
command! -nargs=0 CopyModeEnable :call utils#copymode_enable()

function! utils#copymode_disable()
  set relativenumber
  set number
  set list
  call gitgutter#enable()
  call v:lua.vim.notify("Disable Copy Mode", "info", {'title': 'neovim utils'})
endfunction
command! -nargs=0 CopyModeDisable :call utils#copymode_disable()

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
