"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:plugin_list = []

function! YXVim#api#plugin#add(repo)
  call add(s:plugin_list, repo)
endfunction

#call dein#add(repo)
