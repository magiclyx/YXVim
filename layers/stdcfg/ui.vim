"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/09/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echom 'ui.vim'

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


" Background and Scheme
set background=dark
colorscheme desert

" Enable 256 colors on gnome
if $COLORTERM ==# 'gnome-terminal'
    set t_Co=256
endif





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Redraw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Redraw the screen frequently
set nolazyredraw




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" left/ right
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Allow specified keys that move the cursor left/right to move to
"the previous/next line when the cursor is on the first/last character in the line.
"set whichwrap+=<,>,h,l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" number of line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shou number and relativenumber
set number
set relativenumber



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fillchar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set fillchar
hi VertSplit ctermbg=NONE guibg=NONE
set fillchars+=vert:│




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show cmd on right bottom corner
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set noshowcmd
set showcmd



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the line and column number of the cursor position on the right bottom
" corner.
set ruler


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show wildmenu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"The value of this option influences when the last window will have a status line:
"        0: never
"        1: only if there are at least two windows
"        2: always
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Short message
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't give ins-completion-menu messages.
if has('patch-7.4.314')
    set shortmess+=c
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open default foldenable (it's default mod)
set foldenable



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
" Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" please install the font in 'Dotfiles\font'
if YXVim#api#system#Windows()
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




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No sounds on error
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set noerrorbells
"set novisualbell
"set t_vb=















