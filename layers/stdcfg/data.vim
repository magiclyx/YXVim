"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/19/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echo 'data.vim'

let g:Data_Buckup_Dir = g:Data_Home.'/buckup'
let g:Data_Swap_Dir = g:Data_Home.'/swap'
let g:Data_Undo_Dir = g:Data_Home.'/undofile'


if finddir(g:Data_Home) ==# ''
    silent call mkdir(g:Data_Home)
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buckup
"
"'backup' 'writebackup'  action
"   off       off        no backup made
"   off       on         backup current file, deleted afterwards (default)
"   on        off        delete old backup, backup current file
"   on        on         delete old backup, backup current file
"
" We save the buckup file until I open it next time.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if finddir(g:Data_Buckup_Dir) ==# ''
    silent call mkdir(g:Data_Buckup_Dir)
endif

set backup
set writebackup
let &backupdir=g:Data_Buckup_Dir



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if finddir(g:Data_Undo_Dir) ==# ''
    silent call mkdir(g:Data_Undo_Dir)
endif

set undofile
set undolevels=1000

let &undodir=g:Data_Undo_Dir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if finddir(g:Data_Swap_Dir) ==# ''
    silent call mkdir(g:Data_Swap_Dir)
endif

let &directory=g:Data_Swap_Dir


