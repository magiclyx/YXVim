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

" set user config Home
let g:Config_User_Home = g:Src_Main_Home.'/.YXVim.d'

" set layer Main Home
let g:Layer_Main_Home = g:Src_Main_Home.'/layers'

" set data Home
let g:Data_Home = $HOME.'/.data/vim'

" set binary Main Home
let g:App_Main_Home = g:Data_Home.'/bin'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup data dir
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if finddir(g:Data_Home) ==# ''
    silent call mkdir(g:Data_Home)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup app dir
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if finddir(g:App_Main_Home) ==# ''
    silent call mkdir(g:App_Main_Home)
endif

let $PATH .= g:App_Main_Home


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

" load main configure
call YXVim#api#base#source(g:Config_User_Home.'/vimrc')

" load all layers
call YXVim#api#layer#load()

" load plugin
call YXVim#api#base#source(g:Config_Main_Home.'/plugin.vim')

" load global menu
call YXVim#api#base#source(g:Config_Main_Home.'/globalmenu.vim')


" call YXVim#api#base#source(s:_current_file_dir.'/test.vim')


" load quick menu
call YXVim#api#base#source(g:Config_Main_Home.'/quickmenu.vim')

" map all global menu key in nnoremap
call YXVim#api#globalmenu#mapping_all_keys()


