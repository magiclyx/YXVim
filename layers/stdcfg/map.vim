"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/24/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move cursor between window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Shift+* to jump between windows
"nnoremap <silent><S-Right> :<C-u>wincmd l<CR>
"nnoremap <silent><S-Left>  :<C-u>wincmd h<CR>
"nnoremap <silent><S-Up>    :<C-u>wincmd k<CR>
"nnoremap <silent><S-Down>  :<C-u>wincmd j<CR>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move line up and down
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent><S-Down> :m .+1<CR>==
nnoremap <silent><S-Up> :m .-2<CR>==
inoremap <silent><S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><S-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent><S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><S-Up> :m '<-2<CR>gv=gv


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
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command sinap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


func! s:CmdDeleteTillSlash()
  let g:cmd = getcmdline()
  if YXVim#api#system#Linux() || YXVim#api#system#OSX()
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if YXVim#api#system#Linux() || YXVim#api#system#OSX()
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! s:CmdCurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc



" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>e<SID>CmdCurrentFileDir("e")<cr>
cno $q <C-\>e<SID>CmdDeleteTillSlash()<cr>




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
" use '*' or '#' in virsual mode 
" use <leader>g begin search with vimgrep
" use <leader>* fast search in visual mode and normal mode
"
" Inspired by visual-star-search.vim in github
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C-r: Easier search and replace
function! s:VSetSearch() abort
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction



function! s:VStartSearchMenu(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction



" From an idea by Michael Naumann
function! s:VStarSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call s:VStartSearchMenu("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif
 
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" use <c-r> to search current seletion
xnoremap <C-r> :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>


"  In visual mode when you press * or # to search for the current selection
xnoremap <silent> * :<C-u>call <SID>VStarSearch('f')<CR>
xnoremap <silent> # :<C-u>call <SID>VStarSearch('b')<CR>

" When you press gv you vimgrep after the selected text
xnoremap <silent> gv :<C-u>call <SID>VStarSearch('gv')<CR>


map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

