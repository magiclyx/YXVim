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



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" install dein if need
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:dein_plugin_dir = g:Data_Plugin_Dir . '/repos/github.com/Shougo/dein.vim'
if ! filereadable(s:dein_plugin_dir . '/README.md')
	if executable('git')
        echom 'install dein...'
        echom 'git clone https://github.com/Shougo/dein.vim ...'
		call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(expand(s:dein_plugin_dir)))
        if !empty(v:shell_error)
		  echohl WarningMsg
		  echom v:shell_error
		  echohl None
		  execute 'quitall!'
		endif
	else
		echohl WarningMsg
		echom 'You need install git!'
		echohl None
        execute 'quitall!'
	endif
endif

exec 'set runtimepath+='. s:dein_plugin_dir



"if &compatible
"  set nocompatible
"endif



if dein#load_state(g:Data_Plugin_Dir)
  call dein#begin(g:Data_Plugin_Dir)

  call dein#add(s:dein_plugin_dir)

  let all_plugin_list = YXVim#api#plugin#get_all()
  for plugin in all_plugin_list

    let s:repo = get(plugin, 'name', v:t_none)
    let s:optional = get(plugin, 'optional', {})
    if type(s:repo) != v:t_none
      call dein#add(s:repo, s:optional)
    endif
  endfor

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif


  call dein#end()
  call dein#save_state()
endif

silent! let check_plugin = dein#check_install()
if check_plugin
  augroup YXVimCheckInstall
	au!
	au VimEnter * YXInstall
  augroup END
endif

call dein#call_hook('source')

filetype plugin indent on


let g:Plugin_Job_Maxprocesses = 8


command! -nargs=*
      \ -complete=custom,s:complete_plugin
      \ YXUpdate call <SID>update_plugin(<f-args>)

" Command for reinstall plugin, support completion of plugin name. 
command! -nargs=+
      \ -complete=custom,s:complete_plugin
      \ YXReinstall call <SID>reinstall_plugin(<f-args>)

" Command for install plugins.
command! -nargs=* 
      \ -complete=custom,s:complete_plugin
      \ YXInstall call <SID>install_plugin(<f-args>)


let s:update_manager = YXVim#lib#import('update')


function! s:complete_plugin(ArgLead, CmdLine, CursorPos) abort
  echom join(keys(dein#get()) + ['SpaceVim'], "\n")
  return join(keys(dein#get()) + ['SpaceVim'], "\n")
endfunction


function! s:update_plugin(...) abort
    if a:0 == 0
      call s:update_manager.update()
    else
      call s:update_manager.update(a:000)
    endif
endfunction

function! s:reinstall_plugin(...) abort
  call s:update_manager.reinstall(a:000)
endfunction

function! s:install_plugin(...) abort
    if a:0 == 0
      call s:update_manager.install()
    else
      call dein#install(a:000)
    endif
endfunction


