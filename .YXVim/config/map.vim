"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/24/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move cursor between window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Shift+* to jump between windows
nnoremap <silent><S-Right> :<C-u>wincmd l<CR>
nnoremap <silent><S-Left>  :<C-u>wincmd h<CR>
nnoremap <silent><S-Up>    :<C-u>wincmd k<CR>
nnoremap <silent><S-Down>  :<C-u>wincmd j<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move line up and down
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent><C-Down> :m .+1<CR>==
nnoremap <silent><C-Up> :m .-2<CR>==
inoremap <silent><C-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-Up> :m '<-2<CR>gv=gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save a file with sudo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap w!! %!sudo tee > /dev/null %



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Improve zz/c-f/c-b/c-e/c-y
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
      \ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ ."\<C-d>".(line('w$') >= line('$') ? "L" : "H")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ ."\<C-u>".(line('w0') <= 1 ? "H" : "L")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Improve < & > in virtual mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|
