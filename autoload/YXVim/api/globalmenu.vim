"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:global_menu = v:none

let s:LEADERMENU = YXVim#lib#import('leadermenu')

function! YXVim#api#globalmenu#getmenu() abort
  if type(s:global_menu) == v:t_none
    let s:global_menu = s:LEADERMENU.create_menu()
  endif

  return s:global_menu
endfunction


function! YXVim#api#globalmenu#toggle(title, leader) abort
  call s:LEADERMENU.toggle(YXVim#api#globalmenu#getmenu(), a:title, a:leader)
endfunction


function! YXVim#api#globalmenu#set_submenu(menu_name, hotkey, submenu)
  call s:LEADERMENU.set_submenu(s:global_menu, a:menu_name, a:hotkey, a:submenu)
  call YXVim#api#globalmenu#reset_leader_if_need()
endfunction


function! YXVim#api#globalmenu#set_command(command_name, hotkey, command)
  call s:LEADERMENU.set_command(s:global_menu, a:command_name, a:hotkey, a:command)
  call YXVim#api#globalmenu#reset_leader_if_need()
endfunction

let s:last_mapping_keys = []
function! YXVim#api#globalmenu#mapping_all_keys() abort
  let s:last_mapping_keys = s:LEADERMENU.map_globalkeys(s:global_menu, g:yxvim_global_menu_leader, s:last_mapping_keys)
endfunction


let s:last_menu_leader = ''
let s:last_menu_title = ''
function! YXVim#api#globalmenu#reset_leader_if_need()
    let g:yxvim_global_menu_leader = get(g:, 'yxvim_global_menu_leader', '<Space>')
    let g:yxvim_global_menu_title = get(g:, 'yxvim_global_menu_title', 'SPC')

    if s:last_menu_title != g:yxvim_global_menu_title  &&  s:last_menu_leader != g:yxvim_global_menu_leader
      execute "nnoremap " . g:yxvim_global_menu_leader . ' :call YXVim#api#globalmenu#toggle(g:yxvim_global_menu_title, g:yxvim_global_menu_leader)<CR>'
      let s:last_menu_leader = g:yxvim_global_menu_leader
      let s:last_menu_title = g:yxvim_global_menu_title
    endif

endfunction

