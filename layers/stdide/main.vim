"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:VIM_CO = YXVim#lib#import('compatible')

function! s:verify_support_app() abort

  " check sclip
  if ! s:VIM_CO.has_shell_command('xclip')
    if YXVim#api#system#OSX()
      echom 'lack "xclip" command for NERDTree, try "brew install xclip"'
    elseif YXVim#api#system#Linux()
      throw 'not support yet'
    elseif YXVim#api#system#Windows()
      throw 'not support yet'
    else
      throw 'not support yet'
    endif
  endif


  if matchstr(system('brew --prefix ctags; echo $?'), '\d')
    if YXVim#api#system#OSX()
      echom 'lack "ctags" command for Tagbar, try "brew install ctags"'
    elseif YXVim#api#system#Linux()
      throw 'not support yet'
    elseif YXVim#api#system#Windows()
      throw 'not support yet'
    else
      throw 'not support yet'
    endif
  endif

endfunction


function! s:did_activity() abort

  call s:verify_support_app()

  " add tagbar plugin
  call YXVim#api#plugin#add('majutsushi/tagbar')
  " add nerdtree plugin
  call YXVim#api#plugin#add('scrooloose/nerdtree')

  " add tagbar plugin config
  call YXVim#api#base#source(s:_current_file_dir.'/tagbar.vim')
  call YXVim#api#base#source(s:_current_file_dir.'/nerdtree.vim')

endfunction


call YXVim#api#layer#regist('stdide', 
      \ {
        \ 'cb_didActive':function('s:did_activity'),
      \})



