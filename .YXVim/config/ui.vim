"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/09/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight current line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup cursor_line
autocmd!
autocmd WinLeave * set nocursorline 
autocmd WinEnter * set cursorline 
set cursorline
"autocmd WinLeave * set nocursorline nocursorcolumn
"autocmd WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set encoding that how vim shall represent characters internally
set encoding=utf-8
" set encoding that how vim shall writen to file
set fileencoding=utf-8

scriptencoding utf-8

syntax enable
syntax on




















