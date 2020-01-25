"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


let s:filetype_opt = {}
function! YXVim#api#optmenu#regist(hotkey, submenu) abort

  if type(a:hotkey) != v:t_string
    throw 'Hotkey "'. a:hotkey .'" must a string value'
  endif
    
  if type(a:submenu) != v:t_dict
    throw 'submenu not valid type with type:'. type(submenu)
  endif

  let s:filetype_opt[a:hotkey] = a:submenu
endfunction


function! s:auto_adjust_operation_menu()
  let l:filetype = &ft

"  if l:filetype == 'leaderMenu'
"      return
"  endif

  call YXVim#api#globalmenu#set_operation(get(s:filetype_opt, l:filetype, v:none))
  call YXVim#api#globalmenu#mapping_all_keys()
endfunction


augroup YXFileTypeOperationHotKey
  autocmd!
  autocmd BufEnter * call s:auto_adjust_operation_menu()
augroup END


