"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0.0 - 01/28/2020
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 版本号
let s:VERSION = '2.0.0'

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! s:cb_load() abort
  call YXVim#api#plugin#add('vimwiki/vimwiki')

  " add all config 
  call YXVim#api#base#source(s:_current_file_dir.'/wiki.vim')
endfunction


call YXVim#api#layer#regist('wiki', s:VERSION,
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})



