"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#vimlib#leadermenu#get() abort
    return map({
          \'toggle' : '',
          \'create_menu' : '',
          \'set_submenu' : '',
          \'set_command' : '',
          \'map_globalkeys' : '',
          \},
          \"function('s:' . v:key)"
          \)
endfunction


let s:ACTION_SHEET = YXVim#lib#import('actionsheet')
let s:LIST = YXVim#lib#import('list')

let g:LEADERMENU_HSPACE = 5


function! s:create_menu() abort
  let menu_context = {
        \ 'type':'leader_menu',
        \ 'content':{},
        \ }

  return menu_context
endfunction


function! s:set_submenu(menu, item_name, hotkey, submenu) abort
  let a:menu.content[a:hotkey] = {'name':a:item_name, 'content':a:submenu.content}
endfunction


function! s:set_command(menu, item_name, hotkey, command) abort
  let a:menu.content[a:hotkey] = {'name':a:item_name, 'content':a:command}
endfunction


function! s:toggle(menu, title, leader) abort

  let context = {
                \ 'title' : a:title,
                \ 'scheme_name' : '',
                \ 'leader' : a:leader,
				\ 'items' : a:menu.content,
				\ 'current_items' : deepcopy(a:menu.content),
				\ 'path' : [],
                \ 'is_show_help' : v:false,
                \ 'looping_list' : [],
                \ 'is_looping' : v:false,
                \ 'ctrl_context' : {
                                   \ 'path_buckup' : v:none,
                                   \},
				\ }

  call s:start_buffer(context)
endfunction


function! s:map_globalkeys(menu, leader, unmap_list, ...) abort

  let new_mapping = []

  let key_list = []
  if a:0 != 0  && type(a:1) == v:t_list
    let key_list = a:1
  endif

  for existing_keys in a:unmap_list
    silent execute 'nunmap ' . leader . existing_keys
  endfor
  let unmap_list = []

  if type(a:menu.content) == v:t_string

    let combind_key = ''
    for key in key_list
      let combind_key = combind_key . key
    endfor

    "execute 'nnoremap <nowait> ' . a:leader . combind_key . ' :execute "' . a:menu.content . '"<CR>'
    execute 'nnoremap <nowait> ' . a:leader . combind_key . ' :call YXVim#api#base#exec_proclaim("' . a:menu.content . '")<CR>'
    call add(new_mapping, combind_key)
  elseif type(a:menu.content) == v:t_dict

    for key in keys(a:menu.content)
      let new_mapping = extend(new_mapping, s:map_globalkeys(a:menu.content[key], a:leader, [], add(copy(key_list), key)))
    endfor

  endif

  return new_mapping

endfunction


function! s:start_buffer(context)

  let current_items = a:context.items
  for sel_item_dict in a:context.path
    let current_items = get(get(current_items, sel_item_dict.key, {}), 'content', {})
  endfor
  let a:context.current_items = deepcopy(current_items)


  let item_map = filter(a:context.current_items, 'v:key !=# "name"')
  if empty(item_map)
    let item_map = {'error:':{'name':'empty menu item!!'}}
  endif

  let layout = s:calc_layout(item_map)
  let string = s:create_string(layout, item_map)
  let status_line = s:create_status_line(a:context)

  call s:ACTION_SHEET.show('bottom', string, layout.win_dim, {'filetype':'leaderMenu', 'title':status_line})

  call s:binding_keys(a:context)

  call s:wait_for_input(a:context)

endfunc



function! s:calc_layout(item_map)
  let ret = {}
  let item_map = copy(a:item_map)
  let ret.n_items = len(item_map)
  let length = values(map(item_map,
        \ 'strdisplaywidth("[".v:key."]".'.
        \ '(type(v:val) == type({}) ? v:val["name"] : v:val[1]))'))
  let maxlength = max(length) + g:LEADERMENU_HSPACE
  let ret.n_cols = winwidth(0) / maxlength
  let ret.col_width = winwidth(0) / ret.n_cols
  let ret.n_rows = ret.n_items / ret.n_cols + (fmod(ret.n_items,ret.n_cols) > 0 ? 1 : 0)
  let ret.win_dim = ret.n_rows
  return ret
endfunction



function! s:create_string(layout, item_map)
  let l = a:layout
  let l.capacity = l.n_rows * l.n_cols
  let overcap = l.capacity - l.n_items
  let overh = l.n_cols - overcap
  let n_rows =  l.n_rows - 1

  let rows = []
  let row = 0
  let col = 0

  let item_map = copy(a:item_map)
  let item_list = sort(keys(a:item_map), 1)
  for k in item_list
    let desc = item_map[k].name
    let displaystring = "[". k ."] ".desc
    let crow = get(rows, row, [])
    if empty(crow)
      call add(rows, crow)
    endif
    call add(crow, displaystring)
    call add(crow, repeat(' ', l.col_width - strdisplaywidth(displaystring)))

    if col == l.n_cols - 1
      let row +=1
      let col = 0
    else
      let col += 1
    endif
  endfor


  let r = []
  let mlen = 0
  for ro in rows
    let line = join(ro, '')
    call add(r, line)
    if strdisplaywidth(line) > mlen
      let mlen = strdisplaywidth(line)
    endif
  endfor
  call insert(r, '')
  let output = join(r, "\n ")
  return output
endfunction


function! s:escape_keys(inp)
  "let ret = substitute(a:inp, "<", "<lt>", "")
  return substitute(substitute(a:inp, "<", "<lt>", ""), "|", "<Bar>", "")
endfunction


function! s:wait_for_input(context)

  let inp = input("")

  "let ctrl_context = get(a:context, 'ctrl_context', v:none)
  if a:context.is_show_help == v:true

    if inp == '<CONTROL>page_up'
      let end_list_index = max([len(a:context.path) - 2, -1])
      let a:context.path = s:LIST.listpart(a:context.ctrl_context.path_buckup, 0, end_list_index)
    elseif inp == '<CONTROL>page_down'
      let end_list_index = min([len(a:context.path), len(a:context.ctrl_context.path_buckup)-1])
      let a:context.path = s:LIST.listpart(a:context.ctrl_context.path_buckup, 0, end_list_index)
    elseif inp == '<CONTROL>page_home'
      let a:context.path = []
    elseif inp == '<CONTROL>paging_help'
      let a:context.is_show_help = v:false
      let status_line = s:create_status_line(a:context)

      call s:ACTION_SHEET.set_title(status_line, v:false)

      let a:context.ctrl_context.path_buckup = []
    else
      unsilent echom 'unknown command:' . string(inp)
    endif

    call s:LIST.push(a:context.looping_list, a:context)

  else
    if inp ==? ''
      call s:ACTION_SHEET.close()
      doautocmd WinEnter
    elseif match(inp, "^<CONTROL>paging_help") == 0
      let a:context.is_show_help = v:true
      let status_line = s:create_status_line(a:context)

      call s:ACTION_SHEET.set_title(status_line)

      let a:context.ctrl_context.path_buckup = deepcopy(a:context.path)
      
      call s:binding_keys(a:context)
      call s:wait_for_input(a:context)

    else


      let select_dict = get(a:context.current_items, inp, {})
      let content = get(select_dict, 'content', v:none)

      if type(content)==v:t_dict  &&  !empty(content)

          call s:LIST.push(a:context.path, {'key':inp, 'name':select_dict.name})
          call s:LIST.push(a:context.looping_list, a:context)

      elseif type(content) == v:t_string

        call s:ACTION_SHEET.close()
        doautocmd WinEnter

        try
          call YXVim#api#base#exec_proclaim(content)
          "unsilent execute content
        catch
          unsilent echom v:exception
        endtry
      elseif type(content) != v:t_none
          call s:ACTION_SHEET.close()
          doautocmd WinEnter

          unsilent echom 'invalidate menu item dict:' . string(content)
      else
          call s:ACTION_SHEET.close()
          doautocmd WinEnter

          unsilent echom 'no menu item!'
      endif

    endif
  endif

  "looping
  if a:context.is_looping == v:false

    let a:context.is_looping = v:true

    while len(a:context.looping_list) > 0

      call s:ACTION_SHEET.close()
      doautocmd WinEnter

      let loop_context = s:LIST.shift(a:context.looping_list)
      call s:start_buffer(loop_context)
    endwhile

    let a:context.is_looping = v:false

  endif

endfunction


function! s:create_status_line(context) abort
  call s:statusline_scheme_setup(a:context)
  
  let guide_msg = ''
  let status_msg = ''
  if a:context.is_show_help == v:false
    let guide_msg = '[C-h control-mode]'
  else
    let guide_msg = 'n:next-page, p:pre-page, h:home-page'
    let status_msg = '[lock]'
  endif

  let path_string = ''
  for path_dict in a:context.path
    let path_string = printf(' > %s[%s]%s', path_string, s:escape_keys(path_dict.key), path_dict.name)
  endfor

  
  let status_line_string = '%#LeaderMenuPrompt#' . a:context.title .
							\ '%#LeaderMenuSep1#' . '' .
							\ '%#LeaderMenuName#' . path_string .
							\ '%#LeaderMenuSep2#' . '   ' .
                            \ '%#LeaderMenuFill#' . guide_msg .
                            \ '%=%#LeaderMenuPrompt#' . status_msg
  return substitute(status_line_string, ' ', '\\ ', 'g')
endfunction



function! s:binding_keys(context)

  let item_map = deepcopy(filter(a:context.current_items, 'v:key !=# "name"'))
  let item_list = sort(keys(item_map), 1)

  if a:context.is_show_help == v:true

    for k in item_list

      let key = substitute(k, "|", "<Bar>", "")

      if ! empty(maparg(key, "c", 0, 1))
        silent execute "cunmap <silent> <buffer> " . key
      endif

    endfor

    execute 'cnoremap <silent> <buffer> p <CONTROL>page_up<CR>'
    execute 'cnoremap <silent> <buffer> n <CONTROL>page_down<CR>'
    execute 'cnoremap <silent> <buffer> h <CONTROL>page_home<CR>'

    execute 'cnoremap <nowait> <silent> <buffer> <esc> <CONTROL>paging_help<CR>'
    execute 'cnoremap <nowait> <silent> <buffer> <c-c> <CONTROL>paging_help<CR>'

    if type(a:context.leader) == v:t_string
      execute 'cnoremap <nowait> <silent> <buffer> ' . a:context.leader . ' <CONTROL>paging_help<CR>'
    endif

  else

    if ! empty(maparg("p", "c", 0, 1))
      silent execute 'cunmap <silent> <buffer> ' . 'p'
    endif

    if ! empty(maparg("n", "c", 0, 1))
      silent execute 'cunmap <silent> <buffer> ' . 'n'
    endif


    if ! empty(maparg("r", "c", 0, 1))
      silent execute 'cunmap <silent> <buffer> ' . 'r'
    endif

    for k in item_list
      silent execute "cnoremap <nowait> <buffer> ".substitute(k, "|", "<Bar>", ""). " " . s:escape_keys(k) ."<CR>"
    endfor

    execute 'cnoremap <nowait> <silent> <buffer> <c-c> <esc>'

    if type(a:context.leader) == v:t_string
      execute 'cnoremap <nowait> <silent> <buffer> ' . a:context.leader . ' ' . a:context.leader . '<CR>'
    endif

  endif


  cnoremap <nowait> <buffer> <Space> <Space><CR>
  cnoremap <nowait> <buffer> <silent> <C-h> <CONTROL>paging_help<CR>

  "if empty(maparg("<c-c>", "c", 0, 1))
  "  execute 'cnoremap <nowait> <silent> <buffer> <c-c> <esc>'
  "endif

endfunction


function! s:statusline_scheme_setup(context)
  let scheme_name = get(g:, 'colors_name', 'gruvbox')

  if a:context.scheme_name != scheme_name
    let palette = s:get_status_bar_color_palette(scheme_name)

    exe 'hi! LeaderMenuPrompt ctermbg=' . palette[0][2] . ' ctermfg=' . palette[0][3] . ' cterm=bold gui=bold guifg=' . palette[0][0] . ' guibg=' . palette[0][1]
    exe 'hi! LeaderMenuSep1 ctermbg=' . palette[1][2] . ' ctermfg=' . palette[0][2] . ' cterm=bold gui=bold guifg=' . palette[0][1] . ' guibg=' . palette[1][1]
    exe 'hi! LeaderMenuName ctermbg=' . palette[1][2] . ' ctermfg=' . palette[1][3] . ' cterm=bold gui=bold guifg=' . palette[1][0] . ' guibg=' . palette[1][1]
    exe 'hi! LeaderMenuSep2 ctermbg=' . palette[2][2] . ' ctermfg=' . palette[1][2] . ' cterm=bold gui=bold guifg=' . palette[1][1] . ' guibg=' . palette[2][1]
    exe 'hi! LeaderMenuFill ctermbg=' . palette[2][2] . ' ctermfg=' . palette[2][3] . ' guifg=' . palette[2][0] . ' guibg=' . palette[2][1]

    let a:context.scheme_name = scheme_name
  endif

endfunction


function! s:get_status_bar_color_palette(scheme_name) abort

  if a:scheme_name ==# 'molokai'
    return [
            \ ['#080808', '#e6db74', 144, 232],
            \ ['#f8f8f0', '#232526', 16, 253],
            \ ['#f8f8f0', '#293739', 236, 253],
            \ ['#465457', 67],
            \ ['#282828', '#8787af', 235, 103],
            \ ['#282828', '#ffd700', 235, 220],
            \ ['#282828', '#ff5f5f', 235, 203],
            \ ]
  elseif a:scheme_name ==# 'solarized' || a:scheme_name ==# 'NeoSolarized'
    if &background ==# 'light'
      return [
            \ ["#002b36", "#586e75", 10, 8],
            \ ["#073642", "#93a1a1",  14,  0],
            \ ["#073642", "#839496",  12,  0],
            \ ["#eee8d5",  7],
            \ ["#002b36", "#268bd2",   8, 4],
            \ ["#002b36", "#cb4b16", 8, 9],
            \ ["#002b36", "#2aa198",   8, 6],
            \ ]
    else
      return [
            \ ["#fdf6e3",  "#93a1a1",  14,  15],
            \ ["#eee8d5",  "#586e75", 10, 7],
            \ ["#eee8d5",  "#657b83", 11, 7],
            \ ["#073642", 0],
            \ ["#fdf6e3",  "#268bd2",   15, 4],
            \ ["#fdf6e3",  "#cb4b16", 15, 9],
            \ ["#fdf6e3",  "#2aa198",   15, 6],
            \ ]
    endif
  elseif a:scheme_name ==# 'nord'
    return [
            \ ['#2E3440', '#A3BE8C', 0, 2],
            \ ['#D8DEE9', '#3E4452', 7, 8],
            \ ['#D8DEE9', '#434C5E', 7, 8],
            \ ['#4C566A', 8],
            \ ['#2E3440', '#8FBCBB', 0, 14],
            \ ['#2E3440', '#D08770', 0, 11],
            \ ['#2E3440', '#BF616A', 0, 1],
            \ ]
  elseif a:scheme_name ==# 'one'
    return [
            \ ['#2c323c', '#98c379', 114, 16],
            \ ['#abb2bf', '#3b4048', 16, 145],
            \ ['#abb2bf', '#2c323c', 16, 145],
            \ ['#2c323c', 16],
            \ ['#2c323c', '#afd7d7', 114, 152],
            \ ['#2c323c', '#ff8787', 114, 210],
            \ ['#2c323c', '#d75f5f', 114, 167],
            \ ['#2c323c', '#689d6a', 114, 72],
            \ ['#2c323c', '#8f3f71', 114, 132],
            \ ]
  elseif a:scheme_name ==# 'onedark'
    return [
            \ ['#282C34', '#98C379', 114, 235],
            \ ['#ABB2BF', '#3E4452', 236, 144],
            \ ['#ABB2BF', '#3B4048', 238, 144],
            \ ['#5C6370', 59],
            \ ['#282c34', '#00af87', 235, 36],
            \ ['#282c34', '#ff8700', 235, 208],
            \ ['#282c34', '#af5f5f', 235, 131],
            \ ]
  elseif a:scheme_name ==# 'SpaceVim' 
    " for Spacevim scheme
    return [
            \ ['#282828' , '#FFA500' , 250, 97],
            \ ['#d75fd7' , '#4e4e4e' , 170 , 239],
            \ ['#c6c6c6' , '#3a3a3a' , 251 , 237],
            \ ['#2c323c', 16],
            \ ['#282828', '#00BFFF', 114, 152],
            \ ['#2c323c', '#ff8787', 114, 210],
            \ ['#2c323c', '#d75f5f', 114, 167],
            \ ]
  else
    " use gruvbox scheme as default
    return [
            \ ['#282828', '#a89984', 246, 235],
            \ ['#a89984', '#504945', 239, 246],
            \ ['#a89984', '#3c3836', 237, 246],
            \ ['#665c54', 241],
            \ ['#282828', '#83a598', 235, 109],
            \ ['#282828', '#fe8019', 235, 208],
            \ ['#282828', '#8ec07c', 235, 108],
            \ ['#282828', '#689d6a', 235, 72],
            \ ['#282828', '#8f3f71', 235, 132],
            \ ]
  endif

endfunction


function! s:test_gottle() abort
  let lmap = {}

  let lmap['A'] = {'name':'TestA'}
  let lmap['B'] = {'name':'TestB', 'content':{'A':{'name':'sub_A'}}}
  "let lmap['B|K'] = {'name':'TestB', 'content':{'A':{'name':'LALAL'}}}
  let lmap['C'] = {'name':'TestC', 'content':'echom "lala"'}
  let lmap['D'] = {'name':'TestD'}
  let lmap['E'] = {'name':'TestE'}
  let lmap['F'] = {'name':'+TestF'}
  let lmap['G'] = {'name':'TestG'}
  let lmap['H'] = {'name':'TestH'}
  let lmap['I'] = {'name':'TestI'}
  let lmap['J'] = {'name':'TestJ'}
  let lmap['K'] = {'name':'TestK'}
  let lmap['L'] = {'name':'TestL'}
  let lmap['M'] = {'name':'TestM'}
  let lmap['N'] = {'name':'TestN'}
  let lmap['O'] = {'name':'TestO'}
  let lmap['P'] = {'name':'TestP'}
  let lmap['Q'] = {'name':'TestQ'}
  let lmap['R'] = {'name':'TestR'}
  let lmap['S'] = {'name':'TestS'}
  let lmap['T'] = {'name':'TestT'}
  let lmap['U'] = {'name':'TestU'}
  let lmap['V'] = {'name':'TestV'}
  let lmap['W'] = {'name':'TestW'}
  let lmap['X'] = {'name':'TestX'}
  let lmap['Y'] = {'name':'TestY'}
  let lmap['Z'] = {'name':'TestZ'}

  let context = {
                \ 'title' : 'Guide',
                \ 'name' : 'SPC',
                \ 'scheme_name' : '',
				\ 'items' : a:menu.content,
				\ 'current_items' : deepcopy(a:menu.content),
				\ 'path' : [],
                \ 'is_show_help' : v:false,
                \ 'looping_list' : [],
                \ 'is_looping' : v:false,
                \ 'ctrl_context' : {
                                   \ 'path_buckup' : v:none,
                                   \},
				\ }

  call s:start_buffer(context)
endfunction


