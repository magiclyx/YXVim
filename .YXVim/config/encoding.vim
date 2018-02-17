"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/10/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the code used inside vim.
" Do not change the encoding value at run time. That would cause weird mistakes.
set encoding=utf-8

" In order to avoid non-UTF-8 systems such as Windows, menus and system prompts garbled,
" you can do these settings at the same time:
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8


" The encoding used to display information on the screen,
" it needs to be the same as the vim internal encoding.
" Note that remote login needs to be the same as the remote vim internal encoding.
" Gvim ignores this setting
set termencoding=utf-8



" Automatic coding recognition.
" Note, be sure to put strict coding on the front and loose coding on the back. The following order is recognized as more reliable
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


" Specify the character encoding used in the script.
scriptencoding utf-8




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup fencview
" https://vim.sourceforge.io/scripts/script.php?script_id=1708
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load fencview
call YXVim#api#base#plugin_load('fencview')

" If tellenc is executable, it will  be used by default. (default value)
" If you still want to use  the detection mechanism of this script, set the value to "fencview".
let $FENCVIEW_TELLENC = 'tellenc'

" set auto detect file encoding when you open a file.
let g:fencview_autodetect = 1


" let g:fencview_auto_patterns = ?
" Set this variable in your vimrc to decide the pattern of file names to enable autodetection.
" (default: '*.txt,*.htm{l\=}')


" let g:fencview_checklines = ?
" It checks first and last several lines of current file,
" so don't set the value too large.
" Set to 0 if you want to check every line." (default: 10)

























