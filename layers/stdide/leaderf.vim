"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/26/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


" don't show the help in normal mode

let g:Lf_HideHelp = get(g:, 'Lf_HideHelp', 1)
let g:Lf_UseCache = get(g:, 'Lf_UseCache', 0)
let g:Lf_UseVersionControlTool = get(g:, 'Lf_UseVersionControlTool', 0)
let g:Lf_IgnoreCurrentBufferName = get(g:, 'Lf_IgnoreCurrentBufferName', 0)
" popup mode
let g:Lf_WindowPosition = get(g:, 'Lf_WindowPosition', 'popup')
let g:Lf_PreviewInPopup = get(g:, 'Lf_PreviewInPopup', 1)
let g:Lf_StlSeparator = get(g:, 'Lf_StlSeparator', { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" })
let g:Lf_PreviewResult = get(g:, 'Lf_PreviewResult', {'Function': 0, 'BufTag': 0 })


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LeaerF about. 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fh :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ripgrep about. 需要安装 ripgrep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" search word under cursor literally only in current buffer
"noremap <leader>gb :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
" search word under cursor in current buffer
noremap <leader>gc :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>


" search word under cursor literally in all listed buffers
"noremap <leader>ga :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>
" search word under cursor in all listed buffers
noremap <leader>gb :<C-U><C-R>=printf("Leaderf! rg --all-buffers -e %s ", expand("<cword>"))<CR>

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
"noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search visually selected text literally, don't quit LeaderF after accepting an entry
"xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
" search visually selected text literally
"xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>

" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
noremap <leader>ga :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>

" recall last search. If the result window is closed, reopen it.
noremap <leader>gr :<C-U>Leaderf! rg --recall<CR>



" search word under cursor in *.h and *.cpp files.
"noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.h -g *.cpp", expand("<cword>"))<CR>
" the same as above
"noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,cpp}", expand("<cword>"))<CR>

" search word under cursor in cpp and java files.
"noremap <Leader>b :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR>

" search word under cursor in cpp files, exclude the *.hpp files
"noremap <Leader>c :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -g !*.hpp", expand("<cword>"))<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add finder menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:leaderKeys(key)
  let l:leader = get(g:,"mapleader","\\")

  if l:leader == ' '
    let l:leader = '1' . l:leader
  elseif l:leader ==# '\'
    let l:leader = '\\'
  endif

  return 'call feedkeys("' . l:leader . a:key . '", "i")'
endfunction


let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:leaderf_menu = s:LEADERMENU.create_menu()

" 'call <SNR>' . s:SID() . '_normalWithLeader("ca")'

call s:LEADERMENU.set_command(s:leaderf_menu, 'File', 'f', s:leaderKeys('ff'))
call s:LEADERMENU.set_command(s:leaderf_menu, 'Buff', 'b', s:leaderKeys('fb'))
call s:LEADERMENU.set_command(s:leaderf_menu, 'Mru', 'm', s:leaderKeys('fm'))
call s:LEADERMENU.set_command(s:leaderf_menu, 'Tag', 't', s:leaderKeys('ft'))
call s:LEADERMENU.set_command(s:leaderf_menu, 'Line', 'l', s:leaderKeys('fl'))
call s:LEADERMENU.set_command(s:leaderf_menu, 'Function', 'h', s:leaderKeys('fh'))



" let s:grep_menu = s:LEADERMENU.create_menu()
" call s:LEADERMENU.set_submenu(s:leaderf_menu, 'Grep', 'g', s:grep_menu)
" call s:LEADERMENU.set_command(s:grep_menu, 'Current buff', 'c', s:leaderKeys('gb'))
" call s:LEADERMENU.set_command(s:grep_menu, 'Buff', 'b', s:leaderKeys('gm'))
" call s:LEADERMENU.set_command(s:grep_menu, 'Append Search', 'a', s:leaderKeys('ga'))
" call s:LEADERMENU.set_command(s:grep_menu, 'Repead Last Search', 'r', s:leaderKeys('gr'))


let s:help_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:leaderf_menu, 'Help', '?', s:help_menu)


"open menu
let s:open_help_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:help_menu, 'Open', 'o', s:open_help_menu)

call s:LEADERMENU.set_command(s:open_help_menu, 'Open in horizontal split window', '<C-X>', '')
call s:LEADERMENU.set_command(s:open_help_menu, 'Open in vertical split window', '<C-]>', '')
call s:LEADERMENU.set_command(s:open_help_menu, 'Open in new tabpage', '<C-T>', '')


" select menu
let s:open_select_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:help_menu, 'Select', 's', s:open_select_menu)

call s:LEADERMENU.set_command(s:open_select_menu, 'Select multiple files', '<C-S>', '')
call s:LEADERMENU.set_command(s:open_select_menu, 'Select all files', '<C-A>', '')


" switch model
let s:open_model_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:help_menu, 'Model', 'm', s:open_model_menu)

call s:LEADERMENU.set_command(s:open_model_menu, 'Switch to normal mode', '<Tab>', '')
call s:LEADERMENU.set_command(s:open_model_menu, 'Switch between fuzzy search mode and regex mode', '<C-R>', '')
call s:LEADERMENU.set_command(s:open_model_menu, 'Switch between full path search mode and name only search mode', '<C-F>', '')


" grep model
let s:open_grep_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:help_menu, 'Grep', 'g', s:open_grep_menu)

call s:LEADERMENU.set_command(s:open_grep_menu, 'Grep in current buff', '<leader>gc', '')
call s:LEADERMENU.set_command(s:open_grep_menu, 'Grep in All buff', '<leader>gb', '')
call s:LEADERMENU.set_command(s:open_grep_menu, 'Append result in preview result', '<leader>ga', '')
call s:LEADERMENU.set_command(s:open_grep_menu, 'Recall last search', '<leader>gr', '')



" preview model
let s:open_preview_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:help_menu, 'Preview', 'p', s:open_preview_menu)

call s:LEADERMENU.set_command(s:open_preview_menu, 'Preview window', '<C-P>', '')
call s:LEADERMENU.set_command(s:open_preview_menu, 'Scroll in in preview window', '<C-UP>', '')
call s:LEADERMENU.set_command(s:open_preview_menu, 'Scroll down in preview window', '<C-DOWN>', '')

" other
call s:LEADERMENU.set_command(s:help_menu, 'Quite', '<Esc>', '')


" 注册
call YXVim#api#globalmenu#set_submenu('LeaderF', 'f', s:leaderf_menu)

