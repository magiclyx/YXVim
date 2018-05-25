"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:LEADERMENU = YXVim#lib#import('leadermenu')
let s:plugin_key = 'p'
let s:plugin_name = 'plugin'


let s:global_menu = v:none
function! YXVim#api#globalmenu#getmenu() abort
  if type(s:global_menu) == v:t_none
    let s:global_menu = s:LEADERMENU.create_menu()
  endif

  return s:global_menu
endfunction


"let s:global_plugin_menu = v:none
"function! YXVim#api#globalmenu#getpluginmenu() abort
"  if type(s:global_plugin_menu) == v:t_none
"    let s:global_plugin_menu = s:LEADERMENU.create_menu()
"  endif
"
"  return s:global_plugin_menu
"endfunction


function! YXVim#api#globalmenu#toggle(title, leader) abort

  let menu = YXVim#api#globalmenu#getmenu()
"  let plugin_menu = YXVim#api#globalmenu#getpluginmenu()
"
"  if ! empty(plugin_menu.content)  &&  ! has_key(plugin_menu.content, s:plugin_key)
"    call s:LEADERMENU.set_submenu(s:global_menu, s:plugin_name, s:plugin_key, plugin_menu)
"  elseif empty(plugin_menu.content)  &&  has_key(plugin_menu.content, s:plugin_key)
"    call remove(menu.content, s:plugin_key)
"  endif

  call s:LEADERMENU.toggle(menu, a:title, a:leader)

endfunction


function! YXVim#api#globalmenu#set_submenu(menu_name, hotkey, submenu)
  if a:hotkey == s:plugin_key
    throw 'Hotkey "'. a:hotkey .'" is reserved for plugins. You cannot use this.'
  endif

  call s:LEADERMENU.set_submenu(YXVim#api#globalmenu#getmenu(), a:menu_name, a:hotkey, a:submenu)
  call YXVim#api#globalmenu#reset_leader_if_need()
endfunction


function! YXVim#api#globalmenu#set_command(command_name, hotkey, command)

  if a:hotkey == s:plugin_key
    throw 'Hotkey "'. a:hotkey .'" is reserved for plugins. You cannot use this.'
  endif

  call s:LEADERMENU.set_command(YXVim#api#globalmenu#getmenu(), a:command_name, a:hotkey, a:command)
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

