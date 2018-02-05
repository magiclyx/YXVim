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
    call YXVim#api#base#exec_proclaim(':source '.g:Config_Main_Home.'/vimrc')
endfunction

" open the main config file
function! YXVim#api#base#src_open() abort
    call YXVim#api#base#exec_proclaim(':e! '.g:Config_Main_Home.'/main.vim')
endfunction

" load support script
function! YXVim#api#base#load_support(name) abort
    call YXVim#api#base#exec_silent(':source '.g:Support_Main_Home.'/'.a:name)
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










