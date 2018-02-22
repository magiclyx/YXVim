"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#api#system#OSX()
    return has('macunix')
endfunction

function! YXVim#api#system#Linux()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

function! YXVim#api#system#Windows()
    return (has('win16') || has('win32') || has('win64'))
endfunction

