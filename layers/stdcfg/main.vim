"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))



function! s:did_activity() abort
  " load base
  call YXVim#api#base#source(s:_current_file_dir.'/base.vim')

  " load encoding
  call YXVim#api#base#source(s:_current_file_dir.'/encoding.vim')

  " load data
  call YXVim#api#base#source(s:_current_file_dir.'/data.vim')

  " laod buffer
  call YXVim#api#base#source(s:_current_file_dir.'/buffer.vim')

  " load editor
  call YXVim#api#base#source(s:_current_file_dir.'/editor.vim')

  " load ui
  call YXVim#api#base#source(s:_current_file_dir.'/ui.vim')

  " load cmd
  call YXVim#api#base#source(s:_current_file_dir.'/cmd.vim')

  " load completion
  call YXVim#api#base#source(s:_current_file_dir.'/completion.vim')

  " load completion
  call YXVim#api#base#source(s:_current_file_dir.'/map.vim')

endfunction

"g:App_Main_Home
function! s:install() abort
  let src_file = s:_current_file_dir . '/src/tellenc.cpp'
  let app_path = g:App_Main_Home . '/tellenc'
  if executable('clang')
    let command = 'clang++ -o2 ' . src_file . ' -o ' . app_path
  elseif executable('gcc')
    let command = 'g++ -o2 ' . src_file . ' -o ' . app_path
  elseif executable('cl')
    throw 'not implement !!'
  else
    throw 'unknown compiler'
  endif

  call system(command)
  if !empty(v:shell_error)
    echohl WarningMsg
    echom v:shell_error
    echohl None
    throw 'failed to compiled tellenc in stdcfg layer !'
  endif

endfunction

function! s:uninstall() abort
endfunction


call YXVim#api#layer#regist('stdcfg', {'cb_didActive':function('s:did_activity')})



