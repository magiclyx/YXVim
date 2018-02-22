"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! YXVim#lib#vimlib#dict#get() abort
    return map({
          \'get' : '',
          \'remove' : '',
          \},
          \"function('s:' . v:key)"
          \)
endfunction


function! s:get(dict, key, type, ...)

  let default_value = 0
  if a:0 >= 1
    let default_value = a:1
  endif

  let rt_value = get(a:dict, a:key, default_value)
  if type(rt_value) != a:key
    rt_value = default_value
  endif

  return rt_value

endfunction


function! s:remove(dict, key)

  if has_key(a:dict, a:key)
    remove(a:dict, a:key)
  endif

endfunction

