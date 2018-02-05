"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#test2()
    echom "lalal"
endfunction

let s:apis = {}

function! YXVim#lib#import(name) abort
  if has_key(s:apis, a:name)
    return deepcopy(s:apis[a:name])
  endif
  let p = {}
  try
    let p = YXVim#lib#{a:name}#get()
    let s:apis[a:name] = p
  catch /^Vim\%((\a\+)\)\=:E117/
  endtry
  return p
endfunction

function! YXVim#lib#register(name, api) abort
  if !empty(YXVim#lib#import(a:name))
    echoerr '[YXVim lib] Function : ' . a:name . ' already existed!'
  else
    let s:apis[a:name] = deepcopy(a:api)
  endif
endfunction


