"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! YXVim#lib#vimlib#install#get() abort
    return map({
          \'dein' : '',
          \},
          \"function('s:' . v:key)"
          \)
endfunction


function! s:YXVim#lib#vimlib#install#dein() abort

  "auto install dein
  if filereadable(expand(g:Data_Plugin_Dir)
			  \ . join(['repos', 'github.com',
			  \ 'Shougo', 'dein.vim', 'README.md'],
			  \ '/'))
	  let g:spacevim_dein_installed = 1
  else
	  if executable('git')
		  exec '!git clone https://github.com/Shougo/dein.vim "'
					  \ . expand(g:Data_Plugin_Dir)
					  \ . join(['repos', 'github.com',
					  \ 'Shougo', 'dein.vim"'], '/')
		  let g:spacevim_dein_installed = 1
	  else
		  echohl WarningMsg
		  echom 'You need install git!'
		  echohl None
	  endif
  endif
  exec 'set runtimepath+='. fnameescape(g:spacevim_plugin_bundle_dir)
			  \ . join(['repos', 'github.com', 'Shougo',
			  \ 'dein.vim'], s:Fsep)
endfunction

