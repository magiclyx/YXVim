"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/26/2018

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


echom 'completion.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" Setting the pop-up menu behaves like ide
set completeopt=menu,menuone,longest

" .: The current buffer
" w: Buffers in other windows
" b: Other loaded buffers
" u: Unloaded buffers
" t: Tags
" i: Included files
set complete=.,w,b,u,t,i

" Completion of file names and directories ignores case
set wildignorecase

" Determines the maximum number of items to show in the popup menu for
" Insert mode completion.  When zero as much space as available is used
set pumheight=15



