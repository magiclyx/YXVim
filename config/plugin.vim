"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/01/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set plugins dir
let g:Data_Plugin_Dir = g:Data_Home.'/plugins'


" prepare the dir
if finddir(g:Data_Home) ==# ''
    silent call mkdir(g:Data_Home)
endif


if finddir(g:Data_Plugin_Dir) ==# ''
    silent call mkdir(g:Data_Plugin_Dir)
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


let g:Plugin_Job_Maxprocesses = 8


command! -nargs=*
      \ -complete=custom,s:complete_plugin
      \ SPUpdate call <SID>update_plugin(<f-args>)

" Command for reinstall plugin, support completion of plugin name. 
command! -nargs=+
      \ -complete=custom,s:complete_plugin
      \ SPReinstall call <SID>reinstall_plugin(<f-args>)

" Command for install plugins.
command! -nargs=* 
      \ -complete=custom,s:complete_plugin
      \ SPInstall call <SID>install_plugin(<f-args>)


let s:manager = YXVim#lib#import('manager')


function! s:complete_plugin(ArgLead, CmdLine, CursorPos) abort
  echom "abcdefg"
  echom join(keys(dein#get()) + ['SpaceVim'], "\n")
  return join(keys(dein#get()) + ['SpaceVim'], "\n")
endfunction


function! s:update_plugin(...) abort
    if a:0 == 0
      call s:manager.update()
    else
      call s:manager.update(a:000)
    endif
endfunction

function! s:reinstall_plugin(...) abort
  call s:manager.reinstall(a:000)
endfunction

function! s:install_plugin(...) abort
    if a:0 == 0
      call s:manager.install()
    else
      call dein#install(a:000)
    endif
endfunction


