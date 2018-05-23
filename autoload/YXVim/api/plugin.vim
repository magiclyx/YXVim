"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:plugin_list = []

function! YXVim#api#plugin#add(repo)
  call add(s:plugin_list, a:repo)
endfunction

function! YXVim#api#plugin#get_all()
  return s:plugin_list
endfunction

"call dein#add(repo)
