"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/27/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))



" Path of MRU_File
let g:MRU_Home = g:Data_Home.'/mru'
let g:MRU_FILE = g:MRU_Home . '/vim_mru_files'
if finddir(g:MRU_Home) ==# ''
    silent call mkdir(g:MRU_Home)
endif
let MRU_File = get(g:, 'MRU_File', g:MRU_FILE)


" By default, the plugin will remember the names of the last 100 used files.
" As you edit more files, old file names will be removed from the MRU list.
" You can set the MRU_Max_Entries variable to remember more file names.
let MRU_Max_Entries = get(g:, 'MRU_Max_Entries', 1000)

" By default, all the edited file names will be added to the MRU list.
" If you want to exclude file names matching a list of patterns, you can set the MRU_Exclude_Files variable to a list of Vim regular expressions.
" By default, this variable is set to an empty string.
" For example, to not include files in the temporary (/tmp, /var/tmp and D:\temp) directories, you can set the MRU_Exclude_Files variable to
" let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
" let MRU_Exclude_Files = '^D:\\temp\\.*'           " For MS-Windows
" The specified pattern should be a Vim regular expression pattern.
"let MRU_Exclude_Files = get(g:, 'MRU_Exclude_Files', '^/tmp/.*\|^/var/tmp/.*')


" If you want to add only file names matching a set of patterns to the MRU list, then you can set the MRU_Include_Files variable.
" This variable should be set to a Vim regular expression pattern.
" For example, to add only .c and .h files to the MRU list, you can set this variable as below:
" let MRU_Include_Files = '\.c$\|\.h$'
" By default, MRU_Include_Files is set to an empty string and all the edited filenames are added to the MRU list.
" let MRU_Include_Files = get(g:, 'MRU_Include_Files', '')  一般bubu不需要设置这个


" The default height of the MRU window is 8. You can set the MRU_Window_Height variable to change the window height.
let MRU_Window_Height = get(g:, 'MRU_Window_Height', 15)


" By default, when the :MRU command is invoked, the MRU list will be displayed in a new window.
" Instead, if you want the MRU plugin to reuse the current window, then you can set the MRU_Use_Current_Window variable to one.
" The MRU plugin will reuse the current window. When a file name is selected, the file is also opened in the current window.
" let MRU_Use_Current_Window = get(g:, 'MRU_Use_Current_Window', 1)


" When you select a file from the MRU window, the MRU window will be automatically closed and the selected file will be opened in the previous window.
" You can set the MRU_Auto_Close variable to zero to keep the MRU window open.
let MRU_Auto_Close = get(g:, 'MRU_Auto_Close', 1)


" If you don't use the "File->Recent Files" menu and want to disable it, then you can set the MRU_Add_Menu variable to zero.
" By default, the menu is enabled.
" let MRU_Add_Menu = get(g:, 'MRU_Add_Menu', 1)


" If too many file names are present in the MRU list, then updating the MRU menu to list all the file names makes Vim slow.
" To avoid this, the MRU_Max_Menu_Entries variable controls the number of file names to show in the MRU menu.
" By default, this is set to 10. You can change this to show more entries in the menu.
let MRU_Max_Menu_Entries = get(g:, 'MRU_Max_Menu_Entries', 50)



" If many file names are present in the MRU list, then the MRU menu is split into sub-menus.
" Each sub-menu contains MRU_Max_Submenu_Entries file names.
" The default setting for this is 10.
" You can change this to increase the number of file names displayed in a single sub-menu:
let MRU_Max_Submenu_Entries = get(g:, 'MRU_Max_Submenu_Entries', 30)


" When opening a file from the MRU list, the file is opened in the current tab.
" If the selected file has to be opened in a tab always, then set the following variable to 1.
" If the file is already opened in a tab, then the cursor will be moved to that tab.
"let MRU_Open_File_Use_Tabs = get(g:, 'MRU_Open_File_Use_Tabs', 0)





function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 这个方案会污染quickfix list, 所以决定使用mru代替buf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 说明:
  " setqflist() takes a List of Dictionary items describing each error (filename, line number, position, etc.). In this case we're specifying a minimal set of information: the buffer number
  " map() takes a List and an expression (a string) and returns a new List of the expression applied to each item of the input List. Here, we're taking a List of listed buffer numbers and formatting them for use in setqflist() ('{"bufnr": v:val}', where v:val is the value of the item in the list)
  " filter() filters a List, removing elements that don't satisfy a given expression. Here the expression is buflisted(v:val), meaning the buffer number exists and is listed, i.e. appears in :ls output
  " range(a, b) generates a List of numbers from a to b
  " bufnr() returns the number of a given buffer name. If the argument is '$', it returns the highest buffer number
  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" command! YXBuffToQuickfix call setqflist(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), '{"bufnr":v:val}'))

" autocmd BufAdd * YXBuffToQuickfix

" function! s:openbuff() abort
"   call setqflist(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), '{"bufnr": v:val}'))
"   call feedkeys(':belowright copen', 'i')
" endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:mru_autoclose_state_change() abort

    if g:MRU_Auto_Close == 0
        let g:MRU_Auto_Close = 1
        echom 'mru auto close [ON]'
    else
        let g:MRU_Auto_Close = 0
        echom 'mru auto close [OFF]'
    endif

endfunction

" 添加一个命令，用于开关mru自动开关
command! YXMruAutoClose call s:mru_autoclose_state_change()

" YXBuffList 包装了ls 和 Buf 选择页
command! YXBuffList call feedkeys(":ls<CR>:b<Space>", "i")


let s:LEADERMENU = YXVim#lib#import('leadermenu')
let s:buff_menu = s:LEADERMENU.create_menu()

call s:LEADERMENU.set_command(s:buff_menu, 'Buff', 'b', ':YXBuffList')
call s:LEADERMENU.set_command(s:buff_menu, 'Mru', 'm', ':MRU')
call s:LEADERMENU.set_command(s:buff_menu, 'Mru by filter', 'f', 'call feedkeys(":MRU ", "i")')
call s:LEADERMENU.set_command(s:buff_menu, 'Mru edit', 'e', ':e ' . g:MRU_FILE)
call s:LEADERMENU.set_command(s:buff_menu, 'Mru auto close', 's', ':YXMruAutoClose')
call s:LEADERMENU.set_command(s:buff_menu, 'Close', 'q', 'call feedkeys(":q<CR>", "i")')



let s:help_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:buff_menu, 'Help', '?', s:help_menu)

call s:LEADERMENU.set_command(s:help_menu, 'Open in new window', 'o', '')
call s:LEADERMENU.set_command(s:help_menu, 'Open in new Tab', 't', '')
call s:LEADERMENU.set_command(s:help_menu, 'Open readonly', 'v', '')
call s:LEADERMENU.set_command(s:help_menu, 'Update mru list', 'u', '')


" this not work ??!!
" augroup YXMru
"   autocmd!
"   autocmd Filetype mru xmap <buffer> <silent> <Esc> q
" augroup END


" 注册
call YXVim#api#globalmenu#set_submenu('Buff', 'b', s:buff_menu)







"
"
"
"
"
"
"
"
" let s:optional_menu = s:LEADERMENU.create_menu()
"
" let s:comment_optional_menu = s:LEADERMENU.create_menu()
"
" call s:LEADERMENU.set_submenu(s:optional_menu, 'Comment', 'c', s:comment_optional_menu)
"
" call s:LEADERMENU.set_command(s:comment_optional_menu, 'Switch commen type/**/ and //', 's', 'call <SNR>' . s:SID() . '_normalWithLeader("ca")')
"
" call YXVim#api#optmenu#regist(s:support_filetype, s:optional_menu)
"
"
