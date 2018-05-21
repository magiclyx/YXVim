"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echom 'test!test!'

let s:actionsheet = YXVim#lib#import('actionsheet')

"let s:bufnr = -1
let g:leaderGuide_hspace = 5
let s:guide_group = {}

let s:lsep = '>'
let s:rsep = '<'


function! s:start_buffer(item_map)

  let item_map = filter(a:item_map, 'v:key !=# "name"')
  if empty(item_map)
    let item_map = {'error:':{'name':'empty menu item!!'}}
  endif

  let layout = s:calc_layout(item_map)
  let string = s:create_string(layout, item_map)
  let status_line = s:create_status_line('normal')

  call s:actionsheet.show('bottom', string, layout.win_dim, {'filetype':'leaderGuide', 'title':status_line})

  call s:binding_keys(item_map)

  "if empty(maparg("<c-c>", "c", 0, 1))
  "  execute 'cnoremap <nowait> <silent> <buffer> <c-c> <esc>'
  "endif

  call s:wait_for_input(item_map)

endfunc


function! testmenu2#toggle2(mid) abort
  let s:lmap = {}

  let s:lmap['A|B'] = {'name':'TestA'}
  let s:lmap['B'] = {'name':'TestB'}
  let s:lmap['C'] = {'name':'TestC'}
  let s:lmap['D'] = {'name':'TestD'}
  let s:lmap['E'] = {'name':'TestE'}
  let s:lmap['F'] = {'name':'+TestF'}
  let s:lmap['G'] = {'name':'TestG'}
  let s:lmap['H'] = {'name':'TestH'}
  let s:lmap['I'] = {'name':'TestI'}
  let s:lmap['J'] = {'name':'TestJ'}
  let s:lmap['K'] = {'name':'TestK'}
  let s:lmap['L'] = {'name':'TestL'}
  let s:lmap['M'] = {'name':'TestM'}
  let s:lmap['N'] = {'name':'TestN'}
  let s:lmap['O'] = {'name':'TestO'}
  let s:lmap['P'] = {'name':'TestP'}
  let s:lmap['Q'] = {'name':'TestQ'}
  let s:lmap['R'] = {'name':'TestR'}
  let s:lmap['S'] = {'name':'TestS'}
  let s:lmap['T'] = {'name':'TestT'}
  let s:lmap['U'] = {'name':'TestU'}
  let s:lmap['V'] = {'name':'TestV'}
  let s:lmap['W'] = {'name':'TestW'}
  let s:lmap['X'] = {'name':'TestX'}
  let s:lmap['Y'] = {'name':'TestY'}
  let s:lmap['Z'] = {'name':'TestZ'}

  call s:start_buffer(s:lmap)
endfunc


function! s:calc_layout(item_map)
  let ret = {}
  let item_map = copy(a:item_map)
  let ret.n_items = len(item_map)
  let length = values(map(item_map,
        \ 'strdisplaywidth("[".v:key."]".'.
        \ '(type(v:val) == type({}) ? v:val["name"] : v:val[1]))'))
  let maxlength = max(length) + g:leaderGuide_hspace
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
    let desc = type(item_map[k]) == type({}) ? item_map[k].name : item_map[k][1]
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


function! s:wait_for_input(item_map)
  redraw!
  echom 'wait for input'
  let inp = input("")
  echom inp
  if inp ==? ''
    let s:prefix_key_inp = ''
    call s:actionsheet.close()
    doautocmd WinEnter
  elseif match(inp, "^<LGCMD>paging_help") == 0
    let status_line = s:create_status_line('help')
    let s:sheet = s:actionsheet.set_title(status_line)
    redraw!
    "call s:submode_mappings()
  else
    if inp == ' '
      let inp = '[SPC]'
    endif
    let sub_item = get(a:item_map, inp)
    if !empty(sub_item)
      let s:prefix_key_inp = inp
      call s:handle_input(sub_item)
    else
      let s:prefix_key_inp = ''
      call s:actionsheet.close()
      doautocmd WinEnter
    endif
  endif
endfunction

function! s:handle_input(sub_item)
  call s:actionsheet.close()
  if type(a:sub_item) ==? v:t_dict
    "let s:lmap = a:input
    let s:guide_group = a:input
    call s:start_buffer(a:sub_item)
  else
    let s:prefix_key_inp = ''
    "call feedkeys(s:vis.s:reg.s:count, 'ti')
    "redraw!
    try
      unsilent execute a:input[0]
    catch
      unsilent echom v:exception
    endtry
  endif
endfunction


let s:prefix_key_inp = ' '
let s:prefix_key = ' '

function! s:create_status_line(type) abort
  "call SpaceVim#mapping#guide#theme#hi()
  
  let guide_msg = ''
  if a:type ==# 'normal'
    let guide_msg = ' [C-h paging/help]'
  elseif a:type ==# 'help'
    let guide_msg = ' n -> next-page, p -> previous-page, u -> undo-key'
  endif

  echom '======================================='
  echom string(s:guide_group)
  echom string(s:prefix_key_inp)
  echom '======================================='

  let gname = get(s:guide_group, 'name', '')
  if !empty(gname)
    let gname = ' - ' . gname[1:]
    let gname = substitute(gname,' ', '\\ ', 'g')
  endif
  let keys = get(s:, 'prefix_key_inp', '')
  let keys = substitute(keys, '\', '\\\', 'g')
  echom '%#LeaderGuiderPrompt#\ Guide:\ ' .
        \ '%#LeaderGuiderSep1#' . s:lsep .
        \ '%#LeaderGuiderName#\ ' .
        \ s:getName(s:prefix_key)
        \ . keys . gname
        \ . '\ %#LeaderGuiderSep2#' . s:lsep . '%#LeaderGuiderFill#'
        \ . substitute(guide_msg,' ', '\\ ', 'g')
  return '%#LeaderGuiderPrompt#\ Guide:\ ' .
        \ '%#LeaderGuiderSep1#' . s:lsep .
        \ '%#LeaderGuiderName#\ ' .
        \ s:getName(s:prefix_key)
        \ . keys . gname
        \ . '\ %#LeaderGuiderSep2#' . s:lsep . '%#LeaderGuiderFill#'
        \ . substitute(guide_msg,' ', '\\ ', 'g')
endfunction

function! s:binding_keys(item_map)

  let item_map = copy(a:item_map)
  let item_list = sort(keys(a:item_map), 1)
  for k in item_list
    silent execute "cnoremap <nowait> <buffer> ".substitute(k, "|", "<Bar>", ""). " " . s:escape_keys(k) ."<CR>"
  endfor

  cnoremap <nowait> <buffer> <Space> <Space><CR>
  cnoremap <nowait> <buffer> <silent> <C-h> <LGCMD>paging_help<CR>

endfunction



function! s:getName(key) abort
  "if a:key == g:spacevim_unite_leader
  "  return '[unite]'
  "elseif a:key == g:spacevim_denite_leader
  "  return '[denite]'
  if a:key == ' '
    return '[SPC]'
  elseif a:key == 'g'
    return '[g]'
  elseif a:key == 'z'
    return '[z]'
  "elseif a:key == g:spacevim_windows_leader
  ""  return '[WIN]'
  elseif a:key ==# '\'
    return '<leader>'
  else
    return ''
  endif
endfunction


"function! s:guide_help_msg() abort
"  if s:guide_help_mode == 1
"    let msg = ' n -> next-page, p -> previous-page, u -> undo-key'
"  else
"    let msg = ' [C-h paging/help]'
"  endif
"  return substitute(msg,' ', '\\ ', 'g')
"endfunction

