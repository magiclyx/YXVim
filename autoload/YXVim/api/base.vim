"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))

" execute a commands with proclaim
function! YXVim#api#base#exec_proclaim(command)
    echom a:command
    silent execute a:command
endfunction

" execute a commands silent
function! YXVim#api#base#exec_silent(command)
    silent execute a:command
endfunction

" load source
function! YXVim#api#base#source(file)
    execute 'source' a:file
endfunction

" reload all config
function! YXVim#api#base#src_reload() abort
    call YXVim#api#base#exec_proclaim(':source '.g:Config_Main_Home.'/main.vim')
endfunction

" open the main config file
function! YXVim#api#base#src_open() abort
    call YXVim#api#base#exec_proclaim(':e! '.g:Config_Main_Home.'/main.vim')
endfunction

function! YXVim#api#base#leader_keys(...)
  let l:leader = get(g:,"mapleader","\\")

  if l:leader == ' '
    let l:leader = '1' . l:leader
  elseif l:leader ==# '\'
    let l:leader = '\\'
  endif

  return 'call feedkeys("' . l:leader . join(a:000) . '", "i")'
endfunction


function! YXVim#api#base#test2()
    echom "lalal"
endfunction

function! YXVim#api#base#test()
  return map({
        \ 'execute' : '',
        \ 'system' : '',
        \ 'systemlist' : '',
        \ 'version' : '',
        \ 'has' : '',
        \ 'globpath' : '',
        \ },
        \ "function('s:' . v:key)"
        \ )
endfunction



function! YXVim#api#base#getAppSupportPath(app_name) abort
  let app_support_path = g:App_Support_Home.'/'.a:app_name

  if finddir(app_support_path) ==# ''
      silent call mkdir(app_support_path)
  endif

  return app_support_path

endfunction







