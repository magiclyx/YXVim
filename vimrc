"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/07/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let g:Src_Main_Home = s:_current_file_dir

execute 'source' s:_current_file_dir.'/config/main.vim'


" 这个功能，现在会导致menu重复添加，暂时注释掉
" When vimrc is edited, reload it
"augroup autoreload_vimrc
"    autocmd!
"    execute 'autocmd! bufwritepost vimrc source' s:_current_file_path
"augroup END


