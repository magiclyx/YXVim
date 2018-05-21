"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echom 'test!test!'


let s:ACTIONSHEET = YXVim#lib#import('actionsheet')
let s:LEADERMENU = YXVim#lib#import('leadermenu')


let menu = s:LEADERMENU.create_menu()
let submenu = s:LEADERMENU.create_menu()


call s:LEADERMENU.set_command(submenu, 'A', 'A', 'echom "hello world"')

call s:LEADERMENU.set_submenu(menu, 'A', 'A', submenu)
call s:LEADERMENU.set_submenu(menu, 'B', 'B', submenu)
call s:LEADERMENU.set_submenu(menu, 'C', 'C', submenu)
call s:LEADERMENU.set_submenu(menu, 'D', 'D', submenu)
call s:LEADERMENU.set_submenu(menu, 'E', 'E', submenu)
call s:LEADERMENU.set_submenu(menu, 'F', 'F', submenu)
call s:LEADERMENU.set_submenu(menu, 'G', 'G', submenu)
call s:LEADERMENU.set_submenu(menu, 'H', 'H', submenu)
call s:LEADERMENU.set_submenu(menu, 'I', 'I', submenu)
call s:LEADERMENU.set_submenu(menu, 'J', 'J', submenu)
call s:LEADERMENU.set_submenu(menu, 'K', 'K', submenu)
call s:LEADERMENU.set_submenu(menu, 'L', 'L', submenu)
call s:LEADERMENU.set_submenu(menu, 'M', 'M', submenu)
call s:LEADERMENU.set_submenu(menu, 'N', 'N', submenu)
call s:LEADERMENU.set_submenu(menu, 'O', 'O', submenu)
call s:LEADERMENU.set_submenu(menu, 'P', 'P', submenu)
call s:LEADERMENU.set_submenu(menu, 'Q', 'Q', submenu)
call s:LEADERMENU.set_submenu(menu, 'R', 'R', submenu)
call s:LEADERMENU.set_submenu(menu, 'S', 'S', submenu)
call s:LEADERMENU.set_submenu(menu, 'T', 'T', submenu)
call s:LEADERMENU.set_submenu(menu, 'U', 'U', submenu)
call s:LEADERMENU.set_submenu(menu, 'V', 'V', submenu)
call s:LEADERMENU.set_submenu(menu, 'W', 'W', submenu)
call s:LEADERMENU.set_submenu(menu, 'X', 'X', submenu)
call s:LEADERMENU.set_submenu(menu, 'Y', 'Y', submenu)
call s:LEADERMENU.set_submenu(menu, 'Z', 'Z', submenu)


call s:LEADERMENU.toggle(menu, 'SPC')

let s:sheet = submenu

function! s:test()
  let s:sheet = s:ACTIONSHEET.show('bottom', 'lalal', 10, {'filetype':'abc', 'title':'Title'})
  "call s:ACTIONSHEET.show(s:sheet)
endfunction


function! s:test2()
  call s:ACTIONSHEET.close()
endfunction



command! OPEN call s:test()
command! CLOSE call s:test2()



