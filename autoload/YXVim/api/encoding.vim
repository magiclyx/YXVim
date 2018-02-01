"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/12/2018

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))

" toggle encoding panel
function! YXVim#api#encoding#panel_toggle()
    execute 'FencView'
endfunction
