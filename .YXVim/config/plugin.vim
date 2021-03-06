"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/01/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set plugins dir
let g:Data_Plugin_Dir = g:Data_Home.'/plugins'



" prepare the dir
if finddir(g:Data_Home) ==# ''
    silent call mkdir(g:Data_Home, 'p')
endif


if finddir(g:Data_Plugin_Dir) ==# ''
    silent call mkdir(g:Data_Plugin_Dir, 'p')
endif




"if &compatible
"  set nocompatible
"endif


let s:dein_plugin_dir = g:Support_Main_Home.'/dein'


execute 'set runtimepath+='.s:dein_plugin_dir


if dein#load_state(g:Data_Plugin_Dir)
  call dein#begin(g:Data_Plugin_Dir)

  call dein#add(s:dein_plugin_dir)
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif


  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

