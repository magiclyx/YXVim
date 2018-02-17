"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/07/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global Variable
" Config Home & Binary Home
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set a global variable to indicate main home
"let g:Config_Main_Home = fnamemodify(expand('<sfile>'),
"      \ ':p:h:gs?\\?'.((has('win16') || has('win32')
"      \ || has('win64'))?'\':'/') . '?')

" set config Main Home
let g:Config_Main_Home = s:_current_file_dir

" set support Main Home
let g:Support_Main_Home = g:Config_Main_Home.'/support'

" set binary Main Home
let g:Binary_Main_Home = g:Src_Main_Home.'/bin'

" set user config Home
let g:Config_User_Home = g:Src_Main_Home.'/.YXVim.d'

" set data Home
let g:Data_Home = $HOME.'/.data/vim'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" extend $PATH environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $PATH .= g:Binary_Main_Home


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set runtimepath
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set runtimepath^=g:Config_User_Home
execute 'set runtimepath+='.g:Config_User_Home


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fast edit vimrc
nnoremap <leader>e :call YXVim#api#base#src_open()<CR>

" fase reload vimrc
nnoremap <leader>r :call YXVim#api#base#src_reload()<CR>




function! s:tttt()
    call YXVim#api#base#source(s:_current_file_dir.'/test.vim')
endfunction

nnoremap <leader>x :call <SID>tttt()<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" load other configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" load base
call YXVim#api#base#source(s:_current_file_dir.'/base.vim')

" load encoding
call YXVim#api#base#source(s:_current_file_dir.'/encoding.vim')

" load data
call YXVim#api#base#source(s:_current_file_dir.'/data.vim')

" laod buffer
call YXVim#api#base#source(s:_current_file_dir.'/buffer.vim')

" load editor
call YXVim#api#base#source(s:_current_file_dir.'/editor.vim')

" load ui
call YXVim#api#base#source(s:_current_file_dir.'/ui.vim')

" load cmd
call YXVim#api#base#source(s:_current_file_dir.'/cmd.vim')

" load completion
call YXVim#api#base#source(s:_current_file_dir.'/completion.vim')

" load plugin
call YXVim#api#base#source(s:_current_file_dir.'/plugin.vim')


" call YXVim#api#base#source(s:_current_file_dir.'/test.vim')


