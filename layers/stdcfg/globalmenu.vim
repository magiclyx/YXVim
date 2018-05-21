"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 05/22/2018

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:LEADERMENU = YXVim#lib#import('leadermenu')
let global_menu = YXVim#api#globalmenu#getmenu()

" create stdcfg menu page
let s:stdcfg_menu = s:LEADERMENU.create_menu()

" add item to stdcfg menu page
call s:LEADERMENU.set_command(s:stdcfg_menu, 'toggle Encoding', 'e', 'FencView')

" add stdcfg menu page to global menu
call YXVim#api#globalmenu#set_submenu('Basic', 'c', s:stdcfg_menu)


