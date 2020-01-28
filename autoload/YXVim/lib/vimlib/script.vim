"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 1.0 - 01/28/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! YXVim#lib#vimlib#script#get() abort
  return map({'fastrun_cmd' : '',
            \'fastrun_exec' : '',
            \}, "function('s:' . v:key)")
endfunction

function! s:fastrun_cmd(script_path, filetype, ...) abort
endfunction

function! s:fastrun_exec(script_path, filetype, ...) abort
    " TODO 未实现
endfunction

