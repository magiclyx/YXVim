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
" Improve zz, c-f, c-b, c-e, c-y
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
" Improve <Up> and <Down>, Allow them to move between packing lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smart up and down
nnoremap <silent><Down> gj
nnoremap <silent><Up> gk



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Improve < , > in virtual mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation in command line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation in command line with emacs shortkey
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent>g0 :<C-u>tabfirst<CR>
nnoremap <silent>g$ :<C-u>tablast<CR>
nnoremap <silent>gr :<C-u>tabprevious<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-s> :<C-u>w<CR>
vnoremap <C-s> :<C-u>w<CR>
cnoremap <C-s> <C-u>w<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use c-r to fast search/easier/replace the select text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C-r: Easier search and replace
function! s:VSetSearch() abort
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap <C-r> :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>



"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif
 
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
