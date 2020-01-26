"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/26/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


" 在注释符号后加一个空格
let g:NERDSpaceDelims = get(g:, 'NERDSpaceDelims', 1) 

" 紧凑排布多行注释
let g:NERDCompactSexyComs = get(g:, 'NERDCompactSexyComs', 1)

" 逐行注释左对齐
let g:NERDDefaultAlign = get(g:, 'NERDDefaultAlign', 'left') 

" JAVA 语言使用默认的注释符号
let g:NERDAltDelims_java = get(g:, 'NERDAltDelims_java', 1) 

" C 语言注释符号
let g:NERDCustomDelimiters = get(g:, 'NERDCustomDelimiters', {'c': {'left': '/*', 'right': '*/'}})

" 允许空行注释
let g:NERDCommentEmptyLines = get(g:, 'NERDCommentEmptyLines', 1) 

" 取消注释时删除行尾空格
let g:NERDTrimTrailingWhitespace = get(g:, 'NERDTrimTrailingWhitespace', 1)

" 检查选中的行操作是否成功
let g:NERDToggleCheckAllLines = get(g:, 'NERDToggleCheckAllLines', 1)




function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

function! s:normalWithLeader(key)
  let l:leader = get(g:,"mapleader","\\")

  if l:leader == ' '
    let l:leader = '1' . l:leader
  endif

  silent execute ":normal " . l:leader . a:key
endfunction


vmap <silent><C-c> <Plug>NERDCommenterToggle
nmap <silent><C-c> <Plug>NERDCommenterToggle


vmap <silent><S-C> <Plug>NERDCommenterAppend
nmap <silent><S-C> <Plug>NERDCommenterAppend



" use following comman to list all available fletype
" :echo glob($VIMRUNTIME . '/ftplugin/*.vim') OR :echo glob($VIMRUNTIME . '/syntax/*.vim')
let s:support_filetype = ['c', 'ch', 'bash', 'cmake', 'conf', 'config', 'cpp', 'cs', 'csc', 'csh', 'css', 'diff', 'go', 'gdb', 'git', 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'help', 'html', 'htmldjango', 'java', 'javascript', 'javascriptreact', 'json', 'jsp', 'less', 'lftp', 'lua', 'mail', 'mailaliases', 'mailcap', 'make', 'man', 'manconf', 'markdown', 'matlab', 'objc', 'pdf', 'perl', 'perl6', 'php', 'plaintex', 'protocols', 'python', 'r', 'ruby', 'rust', 'sass', 'scheme', 'sh', 'sql', 'svg', 'sysctl', 'tcl', 'tcsh', 'terminfo', 'tex', 'text', 'vb', 'vim', 'xhtml', 'xml', 'xs', 'xsd', 'yaml', 'zsh']



let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:shortkey_menu = s:LEADERMENU.create_menu()

let s:comment_shortkey_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:shortkey_menu, 'Comment', 'c', s:comment_shortkey_menu)

call s:LEADERMENU.set_command(s:comment_shortkey_menu, 'Toggle comment', 'C-c', '')
call s:LEADERMENU.set_command(s:comment_shortkey_menu, 'Comment end line', 'C-S-c', '')


call YXVim#api#shortkeymenu#regist(s:support_filetype, s:shortkey_menu)





let s:optional_menu = s:LEADERMENU.create_menu()

let s:comment_optional_menu = s:LEADERMENU.create_menu()

call s:LEADERMENU.set_submenu(s:optional_menu, 'Comment', 'c', s:comment_optional_menu)

call s:LEADERMENU.set_command(s:comment_optional_menu, 'Switch commen type/**/ and //', 's', 'call <SNR>' . s:SID() . '_normalWithLeader("ca")')

call YXVim#api#optmenu#regist(s:support_filetype, s:optional_menu)

