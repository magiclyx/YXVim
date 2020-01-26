"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {
" name : repo's name
" optional : optional's dict. use ':help dein-options'
" }

let s:plugin_list = []
function! YXVim#api#plugin#add(name, ...)
  let l:repo = {'name':a:name}

  if a:0 > 0 && type(a:1) == v:t_dict
    let l:repo['optional'] = a:1
  endif

  call add(s:plugin_list, l:repo)
endfunction

function! YXVim#api#plugin#get_all()
  return s:plugin_list
endfunction

"call dein#add(repo)
