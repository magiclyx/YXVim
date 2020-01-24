"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! s:cb_load() abort
  call YXVim#api#plugin#add('yianwillis/vimcdoc')
endfunction


call YXVim#api#layer#regist('chinese', 
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})



