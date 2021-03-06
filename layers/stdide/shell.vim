"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/28/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


" for g:VIMSH_DIR, vimshell 配置总目录
let s:data_dir = get(g:, 'VIMSH_DIR', g:Data_Home.'/vimshell')
let g:vimshell_data_directory = get(g:, 'vimshell_data_directory', s:data_dir)

" for g:VIMSHRC_PATH, vimshrc 文件目录(类似.bashrc)
let s:vimrc_path = get(g:, 'VIMSHRC_PATH', s:data_dir.'/.vimshrc')
let g:vimshell_vimshrc_path = get(g:, 'g:vimshell_vimshrc_path', s:vimrc_path)

" Maximum number of entries in history.
" If it is < 0, you can use infinite histories.
" default is 1000
let g:vimshell_max_command_history = get(g:, 'vimshell_max_command_history', 1000)

" Maximum number of directory stacks saved by vimshell.
" Initial value is 100.
let g:vimshell_max_directory_stack = get(g:, 'vimshell_max_directory_stack', 300)


" Vimshell uses this as the Ex command to split window.
" If you set this "nicely", vimshell adjusts with the current window
" size and splits window preferable ("nicely" depends on the winwidth variable). 
" Empty means disabling window splitting on vimshell. 
" \"tabnew\" means vimshell opens new tab. 
" \"vsplit\" means vertical splitting.
let g:vimshell_split_command = get(g:, 'vimshell_split_command', 'nicely')


" This value is split height of |:VimShellPop|. 
" This value is ratio percent against |winheight(0)|.
" Note: It is not used on non vimshell buffers (for example: interactive buffer).
" Default value 30.
let g:vimshell_popup_height = get(g:, 'vimshell_popup_height', 30)

" This is a dictionary value that has keys of the command name that vimshell doesn't save in history.
" 这里的命令，不会出现在history中。以免命令太乱
" Default value is {'history' : 1, 'h' : 1, 'histdel' : 1, 'cd' : 1,}.
let g:vimshell_no_save_history_commands = get(g:, 'vimshell_no_save_history_commands', {'history' : 1, 'h' : 1, 'histdel' : 1, 'cd' : 1,})


" This value is the maximum size of command output.
" Output buffer will be trim down if output is more than this value. 
" Default value is 1000.
let g:vimshell_scrollback_limit = get(g:, 'vimshell_popup_height', 10000)


" If it is non-zero, vimshell will start in insert mode.
" Default value is 1.
let g:vimshell_enable_start_insert = get(g:, 'vimshell_enable_start_insert', 1)


" If it is non-zero, vimshell will stay in insert mode after the command executed.
" Default value is 1.
let g:vimshell_enable_stay_insert = get(g:, 'vimshell_enable_stay_insert', 1)


" You can define additional prompt to substitute a string for this.
" Note: Unlike |g:vimshell_prompt|, it can be a non-fixed string.
" You can get multi-line prompt by separating \"user prompt\" with "\n".

" This example will be helpful to show the current directory every time.
" let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_user_prompt = get(g:, 'vimshell_user_prompt', 'fnamemodify(getcwd(), ":~")')



" It's zsh-like right prompt.
" This value is a string value which is an expression of Vim script.
" Similar to |g:vimshell_user_prompt|, but this calculates the window size,
" and shows the prompt on preferable position.  Initial value is an empty string.
" let g:vimshell_right_prompt = get(g:, 'vimshell_right_prompt', 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")')


" Sets $EDITOR command path. 
" Note: This variable is useful for using editor commands.
" For example, "git commit" or "git rebase -i" commands.
" Note: This feature required GUI Vim and supported |+clientserver| feature.
" Note: To reflect external editor changes, you must write opened temporary buffer and execute |:bdelete| in external editor.
" Note: You *must not* set "core.editor" variable in your .gitconfig.

" Initial value "v:progname --servername=v:servername --remote-tab-wait-silent" or same to |g:vimshell_cat_command|
" 用来解决gvim警告问题
let g:vimshell_editor_command = "v:progname --servername=v:servername --remote-tab-wait-silent"



" Sets vimshell default prompt string.
" Initial value is "vimshell%".
" Note: This is a fixed string.
" You cannot change it dynamically (for example: current directory).
" (cf: |g:vimshell_user_prompt|)

if has('win32') || has('win64')
  " Display user name on Windows.
  let g:vimshell_prompt = get(g:, 'vimshell_prompt', $USERNAME."% ")
else
  " Display user name on Linux.
  let g:vimshell_prompt = get(g:, 'vimshell_prompt', $USER."% ")
endif


function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

function! s:exec_c_cmd()
  let l:file_path = resolve(expand('<cfile>:p'))
  let l:cmd_dir = s:_current_file_dir.'/execm'

  let l:cmd = 'set CR_FILENAME '.l:file_path.';'.l:cmd_dir.'/c.sh'
  echom l:cmd
  return l:cmd

endfunction


" Initialize execute file listobjc.
let s:exec_list = {}

let g:vimshell_execute_file_list = {}
"call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')


let g:vimshell_execute_file_list['txt']    = 'vim'
let g:vimshell_execute_file_list['vim']    = 'vim'
let g:vimshell_execute_file_list['c']      = 'vim'
let g:vimshell_execute_file_list['h']      = 'vim'
let g:vimshell_execute_file_list['cpp']    = 'vim'
let g:vimshell_execute_file_list['d']      = 'vim'
let g:vimshell_execute_file_list['xml']    = 'vim'
let g:vimshell_execute_file_list['java']   = 'vim'
let g:vimshell_execute_file_list['objc']   = 'vim'
let g:vimshell_execute_file_list['objcpp'] = 'vim'

let g:vimshell_execute_file_list['scpt']  = 'osascript'
let g:vimshell_execute_file_list['sh']    = 'bash'
let g:vimshell_execute_file_list['rb']    = 'ruby'
let g:vimshell_execute_file_list['pl']    = 'perl'
let g:vimshell_execute_file_list['py']    = 'python'
let g:vimshell_execute_file_list['html']  = 'open'
let g:vimshell_execute_file_list['xhtml'] = 'open'

"call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

let g:vimshell_interactive_interpreter_commands = g:vimshell_execute_file_list

vnoremap <Leader>ri :'<,'>VimShellSendString<CR>
vnoremap <Leader>rr :'<,'>VimShellSendBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add  menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



func! CompileRun()
  exec "w"
  exec 'VimShellInteractive --split='split | resize 20' irb sh '.s:_current_file_dir.'/src/execmd/run.sh -l '.&filetype.' -p '.resolve(expand("%:p"))
  " if &filetype == 'c'
  "     "exec "!clang -Wall % -o %<"
  "     "exec "VimShellExecute %<"
  " elseif &filetype == 'cpp'
  "     exec "!clang++ -Wall -g -std=c++14 % -o %<"
  "     exec "VimShellExecute %<"
  " elseif &filetype == 'java'
  "     exec "!javac %"
  "     exec "VimShellExecute java %<"
  " elseif &filetype == 'sh'
  "     exec "!chmod a+x %"
  "     exec "VimShellExecute %"
  " elseif &filetype == 'python'
  "     exec "VimShellExecute python %"
  " endif
endfunc



let s:LEADERMENU = YXVim#lib#import('leadermenu')
let s:vimshell_menu = s:LEADERMENU.create_menu()

" 打开一个shell
" Runs vimshell.  The {path} will be its current directory.
" If you omit {path}, it uses Vim's current directory (or does not change the current directory).
" If another vimshell buffer exists in the current tab, switches to the vimshell buffer and changes its current directory to {path}.
" Note: This feature is if installed unite.vim only.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Open', 'oo', ':VimShell')
" Like as |:VimShell|, but move to the current directory.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Open path', 'op', 'call feedkeys(":VimShellCurrentDir ", "i")')
" It's same as |:VimShell|, but creates a new tab.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Open tab', 'ot', ':VimShellTab')
" Like as |:VimShell|, but move to buffer's directory.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Open Buf', 'ob', 'call feedkeys(":VimShellCurrentDir ", "i")')

" 创建一个新的shell
" Runs vimshell as the same :VimShell, but it creates a new vimshell buffer instead of activating other vimshells which are up and running.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Create', 'c', ':VimShellCreate')

" 弹出一个窗口
" Like as |:VimShell|, but this command popups little window.
" It will be your help when you want to make vimshell a bit help.
" To split it, |g:vimshell_popup_command| is suited command.
" Note: It sets |vimshell-options-toggle|.  You can toggle vimshell buffer.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Pop', 'p', ':VimShellPop')


" It does not run vimshell, but launches a terminal program you Specify by {command}, and this program runs in background.
" You can use vimshell like as GNU screen.
" {option} is same to |vimshell-internal-bg| options.  If omit {command}, current buffer path is used.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Execute', 'e', ':VimShellExecute')
call s:LEADERMENU.set_command(s:vimshell_menu, 'Run', 'r', 'call CompileRun()')


" Interactive
call s:LEADERMENU.set_command(s:vimshell_menu, 'Interactive', 'i', 'call feedkeys(":VimShellInteractive ", "i")')
call s:LEADERMENU.set_command(s:vimshell_menu, 'Interactive', 'ii', ':VimShellInteractive')


" Closes the vimshell buffer with {buffer-name}.
" Note: Closes the last vimshell buffer you used in current tab if you skip specifying {buffer-name}.
call s:LEADERMENU.set_command(s:vimshell_menu, 'Quite', 'q', ':VimShellClose')



" Help for 
let s:help_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:vimshell_menu, 'Help', '?', s:help_menu)

call s:LEADERMENU.set_command(s:help_menu, 'Send buf code to interactive', '<Leader>rr', '')
call s:LEADERMENU.set_command(s:help_menu, 'Send Select coede to interactive', '<Leader>ri', '')
call s:LEADERMENU.set_command(s:help_menu, '1.Open a Interactive view. 2.send code to interactive', '.', '')


" 注册
call YXVim#api#globalmenu#set_submenu('Shell', 's', s:vimshell_menu)


