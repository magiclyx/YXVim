"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/19/2018

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab options:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoread
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When a file has been detected to have been changed outside of Vim
" and it has not been changed inside of Vim
set autoread


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open default foldenable (it's default mod)
set foldenable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" match 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When a bracket is inserted, briefly jump to the matching one. 
" The jump is only done if the match can be seen on the screen.
set showmatch
set matchtime=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the line and column number of the cursor position on the right bottom
" corner.
set ruler


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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
syntax on



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Incremental search
set incsearch

" hightlight search
set hlsearch



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"The value of this option influences when the last window will have a status line:
"        0: never
"        1: only if there are at least two windows
"        2: always
set laststatus=2



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When the buffer is discarded (| abandon |), it is kept in memory
set hidden


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Timeout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 'timeout'    'ttimeout'		 action
"   off		      off		     do not time out
"   on		      on or off	     time out on :mappings and key codes
"   off		      on		     time out on key codes

set timeout
set ttimeout
set ttimeoutlen=50


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Short message
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't give ins-completion-menu messages.
if has('patch-7.4.314')
    set shortmess+=c
endif














