"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#test2()
    echom "lalal"
endfunction

let s:apis = {}

let s:has_nvim = has('nvim')

function! YXVim#lib#import(name) abort
  if has_key(s:apis, a:name)
    return deepcopy(s:apis[a:name])
  endif
  let p = {}
"  try

    if s:has_nvim
      echo 'nvim_get'
      echo a:name
      let p = YXVim#lib#neolib#{a:name}#get()
      echo p
    else
      echo 'vim_get'
      echo a:name
      let p = YXVim#lib#vimlib#{a:name}#get()
      echo p
    endif

    let s:apis[a:name] = p
"  catch /^Vim\%((\a\+)\)\=:E117/
"    echo 'failed'
"  endtry

  return p
endfunction

function! YXVim#lib#register(name, api) abort
  if !empty(YXVim#lib#import(a:name))
    echoerr '[YXVim lib] Function : ' . a:name . ' already existed!'
  else
    let s:apis[a:name] = deepcopy(a:api)
  endif
endfunction


