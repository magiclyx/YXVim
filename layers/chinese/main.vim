"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0.0 - 02/17/2018 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 版本号
let s:VERSION = '2.0.0'

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! s:cb_load() abort
  call YXVim#api#plugin#add('yianwillis/vimcdoc')
endfunction


call YXVim#api#layer#regist('chinese', s:VERSION,
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})



