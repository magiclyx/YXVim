"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/27/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:quickfix_menu = s:LEADERMENU.create_menu()


call s:LEADERMENU.set_command(s:quickfix_menu, 'Open', 'o', ':belowright copen')
call s:LEADERMENU.set_command(s:quickfix_menu, 'Close', 'c', ':cclose')
call s:LEADERMENU.set_command(s:quickfix_menu, 'History(<index>chistory to switch)', 'h', ':chistory')

call s:LEADERMENU.set_command(s:quickfix_menu, 'Cmd on line', 'l', 'call feedkeys(":cdo ", "i")')
call s:LEADERMENU.set_command(s:quickfix_menu, 'Cmd on line', 'f', 'call feedkeys(":cfdo ", "i")')
" call s:LEADERMENU.set_command(s:quickfix_menu, 'Buff', 'b', s:leaderKeys('fb'))
" call s:LEADERMENU.set_command(s:quickfix_menu, 'Mru', 'm', s:leaderKeys('fm'))
" call s:LEADERMENU.set_command(s:quickfix_menu, 'Tag', 't', s:leaderKeys('ft'))
" call s:LEADERMENU.set_command(s:leaderquickfix_menuf_menu, 'Line', 'l', s:leaderKeys('fl'))
" call s:LEADERMENU.set_command(s:quickfix_menu, 'Function', 'h', s:leaderKeys('fh'))

" 注册
call YXVim#api#globalmenu#set_submenu('Quickfix', 'q', s:quickfix_menu)


" 使用<C-j>/<C-k>来在文件之间跳跃
augroup YXQuickFix
  autocmd! 
  autocmd Filetype qf nmap <buffer> <silent> <C-j> :cnfile<CR>
  autocmd Filetype qf nmap <buffer> <silent> <C-k> :cpfile<CR>
augroup END

