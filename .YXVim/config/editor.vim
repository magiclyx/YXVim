"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/26/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoread
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When a file has been detected to have been changed outside of Vim
" and it has not been changed inside of Vim
set autoread




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab options:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
"set smarttab do not use this



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bracket
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When a bracket is inserted, briefly jump to the matching one. 
" The jump is only done if the match can be seen on the screen.
set showmatch
set matchtime=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" backspace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent use backspace delete indent, eol use backspace delete line at
" begining start delete the char you just typed in if you do not use set
" nocompatible ,you need this
set backspace=indent,eol,start



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set cindent




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" line break
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" do not break words
" If on, Vim will wrap long lines at a character in
" 'breakat' rather than at the last character that fits on the screen.
set linebreak




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on




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

" ignore search
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Set magic on, for regular expression
set magic



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File formats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if YXVim#api#system#Windows()
    set ffs=unix,dos,mac
elseif YXVim#api#system#OSX()
    set ffs=mac,unix,dos
else
    set ffs=unix,dos,mac
endif

" we dont need it, because the vim may set it bydefault according the system
"set ff=unix




