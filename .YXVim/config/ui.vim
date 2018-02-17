"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/09/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic gui config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    set guioptions-=m " Hide menu bar.
    set guioptions-=T " Hide toolbar
    set guioptions-=L " Hide left-hand scrollbar
    set guioptions-=r " Hide right-hand scrollbar
    set guioptions-=b " Hide bottom scrollbar
    set showtabline=1 " Hide tabline
    set guioptions+=e " Hide tab
endif


" indent use backspace delete indent, eol use backspace delete line at
" begining start delete the char you just typed in if you do not use set
" nocompatible ,you need this
set backspace=indent,eol,start


" Shou number and relativenumber
set number
set relativenumber

" set fillchar
hi VertSplit ctermbg=NONE guibg=NONE
set fillchars+=vert:│


" show cmd on right bottom corner
"set noshowcmd
set showcmd


" indent
set autoindent
set smartindent
set cindent


" show wildmenu
set wildmenu


" do not break words
" If on, Vim will wrap long lines at a character in
" 'breakat' rather than at the last character that fits on the screen.
set linebreak


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Hightlight current line and column
augroup cursor_line
autocmd!
autocmd WinLeave * set nocursorline 
autocmd WinEnter * set cursorline 
set cursorline
"autocmd WinLeave * set nocursorline nocursorcolumn
"autocmd WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn
augroup END

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" please install the font in 'Dotfiles\font'
if YXVim#api#system#OSX()
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
elseif YXVim#api#system#OSX()
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nv














