"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/28/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:optional_menu = s:LEADERMENU.create_menu()
let s:align_optional_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:optional_menu, 'Align', 'a', s:align_optional_menu)

call s:LEADERMENU.set_command(s:align_optional_menu, 'Align', 'a', 'call feedkeys(":Tabularize /", "i")')
call s:LEADERMENU.set_command(s:align_optional_menu, 'Align by "="', '=', ':Tabularize /=')
call s:LEADERMENU.set_command(s:align_optional_menu, 'Align by first ":"', ':', ':Tabularize /:\zs')
call s:LEADERMENU.set_command(s:align_optional_menu, 'Align by ","', ',', ':Tabularize /,')
call s:LEADERMENU.set_command(s:align_optional_menu, 'Align by "<space>"', '<Space>', ':Tabularize / ')

call YXVim#api#optmenu#regist('*', s:optional_menu)



let s:shortkey_menu = s:LEADERMENU.create_menu()
let s:align_shortkey_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:shortkey_menu, 'Align', 'a', s:align_shortkey_menu)

call s:LEADERMENU.set_command(s:align_shortkey_menu, 'Align', ':Tab /<xxx>', '')
call s:LEADERMENU.set_command(s:align_shortkey_menu, 'Align fist', ':Tab /<xxx>\zs', '')


call YXVim#api#shortkeymenu#regist('*', s:shortkey_menu)



"
" let mapleader=','
" if exists(":Tabularize")
"   nmap <Leader>a= :Tabularize /=<CR>
"   vmap <Leader>a= :Tabularize /=<CR>
"   nmap <Leader>a: :Tabularize /:\zs<CR>
"   vmap <Leader>a: :Tabularize /:\zs<CR>
" endif



