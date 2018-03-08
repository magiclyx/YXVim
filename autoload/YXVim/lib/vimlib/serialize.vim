"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#vimlib#serialize#get() abort
  return map({
    \'From' : '',
    \'To' : '',
    \}, "function('s:' . v:key)")
endfunction

function! s:To(obj, file) abort
    call writefile([string(a:obj)], a:file)
endfun


function! s:From(file) abort
    let recover = readfile(a:file)[0]
    " it is so far just a string, make it what it should be:
    execute "let result = " . recover
    return result
endfu
