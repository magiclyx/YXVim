"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:_nerd_tree_support_home = YXVim#api#base#getAppSupportPath('Nerdtree')




let s:VCOP = YXVim#lib#import('compatible')




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show nerdtree on the right side
let g:NERDTreeWinPos=get(g:, "NERDTreeWinPos", "right")

" set nerdtree window size
let g:NERDTreeWinSize = get(g:, 'NERDTreeWinSize', 31)

" indicate the bookmark path
let g:NERDTreeBookmarksFile = get(g:, "NERDTreeBookmarksFile", s:_nerd_tree_support_home.'/NERDTreeBookmarks')

" Do not sort the book mark.(Because we have indicate a bookmak file)
let g:NERDTreeBookmarksSort = get(g:, "NERDTreeBookmarksSort", 0)

" tree ignore following files
let g:NERDTreeIgnore = get(g:, "NERDTreeIgnore", ['\~$', '\.pyc$', '\.swp$'])

" non-case sensitive when sorted by file name
let g:NERDTreeCaseSensitiveSort = get(g:, "NERDTreeCaseSensitiveSort", 0)

" always change the crrent working directory when change the root directory of
" the tree
let g:NERDTreeChDirMode = get(g:, "NERDTreeChDirMode", 2)

" Instead of showing netrw when editing a directory, open NerdTree
let g:NERDTreeHijackNetrw = get(g:, "NERDTreeHijackNetrw", 1)

" Do not show the book marks(use 'B' to show it)
let g:NERDTreeShowBookmarks = get(g:, "NERDTreeShowBookmarks", 1)

" Do not show the help panel
let g:NERDTreeMinimalUI = get(g:, "NERDTreeMinimalUI", 1)

" Do not close the three when open a file(it's the default value)
let g:NERDTreeQuitOnOpen = get(g:, "NERDTreeQuitOnOpen", 0)

" Tells the NERD tree to hightlight the cursor line
let g:NERDTreeHighlightCursorline = get(g:, "NERDTreeQuitOnOpen", 1)

let g:NERDTreeShowFiles = get(g:, "NERDTreeShowFiles", 1)

" collapses on the same line directories that have only one child directory.
let g:NERDTreeCascadeSingleChildDir = get(g:, "NERDTreeCascadeSingleChildDir", 0)

" Cascade open while selected directory has only one child that also is a
" directory
let g:NERDTreeCascadeOpenSingleChildDir = get(g:, "NERDTreeCascadeOpenSingleChildDir", 1)

"auto refresh
let g:NERDTreeAutoDeleteBuffer = get(g:, "NERDTreeAutoDeleteBuffer", 1)

" show liine numbre in nerdtree
let g:NERDTreeShowLineNumbers = get(g:, "NERDTreeShowLineNumbers", 1)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add NERDTree menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:LEADERMENU = YXVim#lib#import('leadermenu')

let tree_menu = s:LEADERMENU.create_menu()


call s:LEADERMENU.set_command(tree_menu, 'Toggle', 't', 'NERDTreeToggle')
call s:LEADERMENU.set_command(tree_menu, 'Open Mirror', 'm', 'NERDTreeMirror')
call s:LEADERMENU.set_command(tree_menu, 'Open to CWD', 'o', 'NERDTreeCWD')
call s:LEADERMENU.set_command(tree_menu, 'Find', 'f', 'call feedkeys(":NERDTreeFind ", "i")')

"add bookmark menu"
let bookmark_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(tree_menu, 'Bookmark', 'm', bookmark_menu)

call s:LEADERMENU.set_command(bookmark_menu, 'Open', 'o', 'call feedkeys(":NERDTreeFromBookmark ", "i")')

call s:LEADERMENU.set_command(bookmark_menu, 'Add', 'a', 'call feedkeys(":Bookmark ", "i")')
call s:LEADERMENU.set_command(bookmark_menu, 'Delete', 'd', 'call feedkeys(":ClearBookmarks ", "i")')
call s:LEADERMENU.set_command(bookmark_menu, 'Clear', 'c', 'ClearAllBookmarks')

"if exists('t:NERDTreeBufName')
""  if bufname('%') == t:NERDTreeBufName
call s:LEADERMENU.set_command(bookmark_menu, 'Fresh(in NerdTree buff)', 'f', 'ReadBookmarks') "just work in NERDTree window
""  endif
"endif


call s:LEADERMENU.set_command(bookmark_menu, 'Set root', 's', 'call feedkeys(":BookmarkToRoot ", "i")')
call s:LEADERMENU.set_command(bookmark_menu, 'Reveal', 'r', 'call feedkeys(":RevealBookmark ", "i")')


call YXVim#api#globalmenu#set_submenu('NERDTree', 't', tree_menu)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" private function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Check if NERDTree is open or active
function! s:isNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! s:find_current_file_in_nerd_tree()
  if &modifiable && s:isNERDTreeOpen() && strlen(expand('%')) > 0 && expand('%:p:h') =~ getcwd().'/.*' && !&diff
    NERDTreeFind
    wincmd p
  else
    echom "can not find ".@%." in CWD"
  endif
endfunction

" past file to xclip clipboard
function! s:paste_to_file_manager() abort
  let path = g:NERDTreeFileNode.GetSelected().path.str()
  echom "<-" . path
  if !isdirectory(path)
    let path = fnamemodify(path, ':p:h')
  endif
  let old_wd = getcwd()
  if old_wd == path
    call s:VCOP.systemlist(['xclip-pastefile'])
  else
    noautocmd exe 'cd' fnameescape(path)
    call s:VCOP.systemlist(['xclip-pastefile'])
    noautocmd exe 'cd' fnameescape(old_wd)
  endif
endfunction

" copy file to xclip clipboard
function! s:copy_to_system_clipboard() abort
  let filename = g:NERDTreeFileNode.GetSelected().path.str()
  echom "->" . filename
  call s:VCOP.systemlist(['xclip-copyfile', filename])
  echo 'Yanked:' . (type(filename) == 3 ? len(filename) : 1 ) . ( isdirectory(filename) ? 'directory' : 'file'  )
endfunction


function! s:nerdtreeinit() abort
  nnoremap <silent><buffer> yY  :<C-u>call <SID>copy_to_system_clipboard()<CR>
  nnoremap <silent><buffer> P  :<C-u>call <SID>paste_to_file_manager()<CR>
endfunction



" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set hightlight for filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Using yY and P to copy file between tree
" exit when only tree widnow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup NERDTreeAutoExist
  autocmd!
  autocmd bufenter *
        \ if (winnr('$') == 1 && exists('b:NERDTree')
        \ && b:NERDTree.isTabTree())
        \|   q
        \| endif
  autocmd FileType nerdtree call s:nerdtreeinit()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" toggle tree
nnoremap <silent> <F3> :NERDTreeToggle<CR>


" Highlight currently open buffer in NERDTree
nnoremap <C-S-J> :call s:find_current_file_in_nerd_tree()<CR>






