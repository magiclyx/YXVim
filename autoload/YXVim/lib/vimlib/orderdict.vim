"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! YXVim#lib#vimlib#orderdict#get() abort
  return map({
        \'init' : '',
        \'len' : '',
        \'add' : '',
        \'get' : '',
        \'remove' : '',
        \'has_key' : '',
        \'dict' : '',
        \'keys' : '',
        \'values' : '',
        \}, "function('s:' . v:key)")
endfunction



function! s:init() abort
  return {
        \'dict' : {},
        \'k_list' : [],
        \'v_list' : [],
        \}
endfunction



function! s:len(od) abort
  return len(a:od.k_list)
endfunction



function! s:add(od, key, val) abort
  if has_key(a:od.dict, a:key)
    let idx = index(a:od.k_list, a:key)
    let a:od.v_list[idx] = a:val
    let a:od.dict[a:key] = a:val
  else
    let a:od.dict[a:key] = a:val
    call add(a:od.k_list, a:key)
    call add(a:od.v_list, a:val)
  endif
  return  a:od
endfunction


function! s:get(od, key, ...) abort

  let default_value = 0
  if a:0 > 0
    let default_value = a:1
  endif

  return get(a:od.dict, a:key, default_value)
endfunction

function! s:remove(od, key) abort
  let idx = index(a:od.k_list, a:key)
  if idx != -1
    remove(a:od.dict, a:key)
    remove(a:od.k_list, idx)
    remove(a:od.v_list, idx)
  endif
endfunction

function! s:has_key(od, key) abort
  return has_key(a:od.dict, a:key)
endfunction


function! s:dict(od) abort
  return copy(a:od.dict)
endfunction


function! s:keys(od) abort
  return copy(a:od.k_list)
endfunction



function! s:values(od) abort
  return copy(a:od.v_list)
endfunction



