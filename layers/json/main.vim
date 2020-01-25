"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0.0 - 01/26/2020
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 版本号
let s:VERSION = '2.0.0'

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! s:cb_load() abort
  call YXVim#api#plugin#add('elzr/vim-json')

  " add all config 
  call YXVim#api#base#source(s:_current_file_dir.'/json.vim')
endfunction


call YXVim#api#layer#regist('json', s:VERSION,
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})


