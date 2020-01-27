"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/28/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))



" This setting makes EasyMotion work similarly to Vim's smartcase option for global searches.
" With this option set, v will match both v and V, but V will match V only. Default: 0.
let g:EasyMotion_smartcase = get(g:, 'EasyMotion_smartcase', 1)

"This applies the same concept, but for symbols and numerals. 1 will match 1 and !; ! matches ! only. Default: 0.
" Smartsign (type `3` and match `3`&`#`)
"g:EasyMotion_use_smartsign_us(US layout) or g:EasyMotion_use_smartsign_jp(JP layout)
let g:EasyMotion_use_smartsign_us = get(g:, 'EasyMotion_use_smartsign_us', 1)

" keep cursor column when JK motion
let g:EasyMotion_startofline = get(g:, 'EasyMotion_startofline', 0)

" Disable default mappings
let g:EasyMotion_do_mapping = get(g:, 'EasyMotion_do_mapping', 0)



" search
map <Leader>js <Plug>(easymotion-s)
"map <Leader>ms <Plug>(easymotion-s2)

" jump ( line OR anywhere )
nmap <Leader>jV <Plug>(easymotion-lineanywhere)
nmap <Leader>jg <Plug>(easymotion-jumptoanywhere)


" F & f
map <Leader>jf <Plug>(easymotion-f)
"map <Leader>jf <Plug>(easymotion-f2)
map <Leader>jF <Plug>(easymotion-F)
"map <Leader>jF <Plug>(easymotion-F2)

" f between window
map <Leader>jxf <Plug>(easymotion-overwin-f)
"map <Leader>jxf <Plug>(easymotion-overwin-f2)


" w & b
map <Leader>jw <Plug>(easymotion-w)
map <Leader>jb <Plug>(easymotion-b)

" w between window
map <Leader>jxw <Plug>(easymotion-overwin-w)

" hijk
map <Leader>jh <Plug>(easymotion-linebackward)
map <Leader>jj <Plug>(easymotion-j)
map <Leader>jk <Plug>(easymotion-k)
map <Leader>jl <Plug>(easymotion-lineforward)

" move line between window
map <Leader>jxl <Plug>(easymotion-overwin-line)

" n & N in search
map <Leader>jn <Plug>(easymotion-n)
map <Leader>jN <Plug>(easymotion-N)



" .
map <Leader>j. <Plug>(easymotion-repeat)



" mapping keys
let s:LEADERMENU = YXVim#lib#import('leadermenu')
let s:motion_menu = s:LEADERMENU.create_menu()

call s:LEADERMENU.set_command(s:motion_menu, 'Search', 's', YXVim#api#base#leader_keys('js'))

call s:LEADERMENU.set_command(s:motion_menu, 'Jump any where', 'g', YXVim#api#base#leader_keys('jg'))
call s:LEADERMENU.set_command(s:motion_menu, 'Jump line', 'V', YXVim#api#base#leader_keys('jV'))


call s:LEADERMENU.set_command(s:motion_menu, 'Find ->', 'f', YXVim#api#base#leader_keys('jf'))
call s:LEADERMENU.set_command(s:motion_menu, 'Find <-', 'F', YXVim#api#base#leader_keys('jF'))

call s:LEADERMENU.set_command(s:motion_menu, 'Wnd find', 'xf', YXVim#api#base#leader_keys('jxf'))

call s:LEADERMENU.set_command(s:motion_menu, 'Word ->', 'w', YXVim#api#base#leader_keys('jw'))
call s:LEADERMENU.set_command(s:motion_menu, 'Word <-', 'b', YXVim#api#base#leader_keys('jb'))

call s:LEADERMENU.set_command(s:motion_menu, 'Wnd word <-', 'xw', YXVim#api#base#leader_keys('jxw'))

call s:LEADERMENU.set_command(s:motion_menu, 'h', 'h', YXVim#api#base#leader_keys('jh'))
call s:LEADERMENU.set_command(s:motion_menu, 'j', 'j', YXVim#api#base#leader_keys('jj'))
call s:LEADERMENU.set_command(s:motion_menu, 'k', 'k', YXVim#api#base#leader_keys('jk'))
call s:LEADERMENU.set_command(s:motion_menu, 'l', 'l', YXVim#api#base#leader_keys('jl'))

call s:LEADERMENU.set_command(s:motion_menu, 'Wnd line', 'xl', YXVim#api#base#leader_keys('jxl'))

call s:LEADERMENU.set_command(s:motion_menu, 'Search ->', 'n', YXVim#api#base#leader_keys('jn'))
call s:LEADERMENU.set_command(s:motion_menu, 'Search <-', 'N', YXVim#api#base#leader_keys('jN'))



call s:LEADERMENU.set_command(s:motion_menu, 'Repead', '.', YXVim#api#base#leader_keys('j.'))



" add help info
let s:help_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:motion_menu, 'Help', '?', s:help_menu)

call s:LEADERMENU.set_command(s:help_menu, 'Search', '<leader>js', '')

call s:LEADERMENU.set_command(s:help_menu, 'Jump any where', '<leader>jg', '')
call s:LEADERMENU.set_command(s:help_menu, 'jump in line', '<leader>jV', '')

call s:LEADERMENU.set_command(s:help_menu, 'Operation line between wnd', '<leader>jxl', '')
call s:LEADERMENU.set_command(s:help_menu, 'Operation in current Wnd', '<leader>m<?>', '')
call s:LEADERMENU.set_command(s:help_menu, 'Operation in all wnd', '<leader>mx<?>', '')
call s:LEADERMENU.set_command(s:help_menu, 'Support vim key', 'f/F, w/b, h/j/k/l, n/N, .', '')



" 注册
call YXVim#api#globalmenu#set_submenu('Jump', 'j', s:motion_menu)




