"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))



function! s:load_configs() abort

  "load base
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

  " load map
  call YXVim#api#base#source(s:_current_file_dir.'/map.vim')

endfunction

function! s:did_activity() abort

  " load configs
  call s:load_configs()

  " setup menu
  call YXVim#api#base#source(s:_current_file_dir.'/globalmenu.vim')

endfunction


call YXVim#api#layer#regist('stdcfg', 
      \ {
        \ 'cb_didActive':function('s:did_activity'),
      \})



