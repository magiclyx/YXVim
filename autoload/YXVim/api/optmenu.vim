"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/25/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:LEADERMENU = YXVim#lib#import('leadermenu')



let s:filetype_opt = {}
function! YXVim#api#optmenu#regist(filetype, submenu) abort

  if type(a:submenu) != v:t_dict
    throw 'submenu not valid type with type:'. type(a:submenu)
  endif


  if type(a:filetype) == v:t_list
      " 如果filetype 是list, 则对列表中每个文件类型进行注册
      for a_filetype in a:filetype
        let l:list = get(s:filetype_opt, a_filetype, [])
        call add(l:list, a:submenu)
        let s:filetype_opt[a_filetype] = l:list
      endfor
  elseif type(a:filetype) == v:t_string
    " 如果filetype 是 string, 则只注册当前的string
    let l:list = get(s:filetype_opt, a:filetype, [])
    call add(l:list, a:submenu)
    let s:filetype_opt[a:filetype] = l:list
  else
    throw 'filetype "'. a:filetype .'" must a string or list value'
  endif


endfunction


function! s:auto_adjust_operation_menu()
  let l:filetype = &ft

"  if l:filetype == 'leaderMenu'
"      return
"  endif

  " 取出当前文件对应的目录
  let l:ft_menu_list = get(s:filetype_opt, l:filetype, [])
  " 取出 * 对应的目录
  let l:star_menu_list = get(s:filetype_opt, '*', [])
  " 目录相加
  let l:menu_list = l:ft_menu_list + l:star_menu_list

  let l:new_menu = s:LEADERMENU.merge_menu(l:menu_list)

  call YXVim#api#globalmenu#set_operation(l:new_menu)
  call YXVim#api#globalmenu#mapping_all_keys()
endfunction


augroup YXFileTypeOperationHotKey
  autocmd!
  autocmd BufEnter * call s:auto_adjust_operation_menu()
augroup END


