"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/18/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:LEADERMENU = YXVim#lib#import('leadermenu')


let s:RKey_OPERATION = 'o'


let s:reserved_key = {}
function! s:reserved_key() abort
    if len(items(s:reserved_key)) == 0
      "operation key
      let s:reserved_key[s:RKey_OPERATION] = {'name':'optional'}
    endif

    return s:reserved_key
endfunction

function! s:is_reserved_key(key) abort
    return has_key(s:reserved_key(), a:key)
endfunction


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
  if s:is_reserved_key(a:hotkey)
    throw 'Hotkey "'. a:hotkey .'" is reserved for plugins. You cannot use this.'
  endif

  call s:LEADERMENU.set_submenu(YXVim#api#globalmenu#getmenu(), a:menu_name, a:hotkey, a:submenu)
  call YXVim#api#globalmenu#reset_leader_if_need()
endfunction


function! YXVim#api#globalmenu#set_command(command_name, hotkey, command)
  if s:is_reserved_key(a:hotkey)
    throw 'Hotkey "'. a:hotkey .'" is reserved for plugins. You cannot use this.'
  endif

  call s:LEADERMENU.set_command(YXVim#api#globalmenu#getmenu(), a:command_name, a:hotkey, a:command)
  call YXVim#api#globalmenu#reset_leader_if_need()
endfunction


function! YXVim#api#globalmenu#set_operation(operationmenu)

  if type(a:operationmenu) != v:t_none
    echom 'set'
    let l:operation_info = get(s:reserved_key(), s:RKey_OPERATION, v:t_none)
    call s:LEADERMENU.set_submenu(YXVim#api#globalmenu#getmenu(), l:operation_info.name, s:RKey_OPERATION, a:operationmenu)
  else
    echom 'clear'
    call s:LEADERMENU.clear_submenu(YXVim#api#globalmenu#getmenu(), s:RKey_OPERATION)
  endif

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

