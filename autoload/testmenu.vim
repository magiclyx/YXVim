"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:bufnr = -1
let g:leaderGuide_hspace = 5
let g:leaderGuide_vertical = v:false
let g:leaderGuide_sort_horizontal = v:false
let s:guide_group = {}

let s:lsep = '>'
let s:rsep = '<'

let s:guide_help_mode = 0

let s:t_ve = ''
function! s:toggle_hide_cursor() abort
  let t_ve = &t_ve
  let &t_ve = s:t_ve
  let s:t_ve = t_ve
endfunction

function! s:winclose()
  echom "winclose"
  call s:toggle_hide_cursor()
  if s:gwin == winnr()
    noautocmd close
    redraw!
    exe s:winres
    let s:gwin = -1
    noautocmd execute s:winnr.'wincmd w'
    call winrestview(s:winv)
  endif
endfunc


function! s:winopen()

  if !exists('s:bufnr')
    let s:bufnr = -1
  endif

  if bufexists(s:bufnr)
	let qfbuf = &buftype ==# 'quickfix'

	noautocmd execute 'botright 1split'
	let bnum = bufnr('%')
	noautocmd execute 'buffer '.s:bufnr
	cmapclear <buffer>
    
    if qfbuf
      noautocmd execute bnum.'bwipeout!'
    endif
  else
	noautocmd execute 'botright 1new'
    let s:bufnr = bufnr('%')
    autocmd WinLeave <buffer> call s:winclose()
  endif

  let s:gwin = winnr()

  setlocal filetype=leaderGuide
  setlocal nonumber norelativenumber nolist nomodeline nowrap
  setlocal nobuflisted buftype=nofile bufhidden=unload noswapfile
  setlocal nocursorline nocursorcolumn colorcolumn=
  setlocal winfixwidth winfixheight

  call s:updateStatusline()
  call s:toggle_hide_cursor()

endfunc



function! s:start_buffer()
  let s:winv = winsaveview()
  let s:winnr = winnr()
  let s:winres = winrestcmd()
  call s:winopen()

  let layout = s:calc_layout()
  let string = s:create_string(layout)

  setlocal modifiable
  if g:leaderGuide_vertical
    noautocmd execute 'vert res '.layout.win_dim
  else
    noautocmd execute 'res '.layout.win_dim
  endif
  silent 1put!=string
  normal! gg"_dd
  setlocal nomodifiable

  "if empty(maparg("<c-c>", "c", 0, 1))
  "  execute 'cnoremap <nowait> <silent> <buffer> <c-c> <esc>'
  "endif

  call s:wait_for_input()

endfunc


function! testmenu2#toggle2(mid) abort
  let s:lmap = {}

  let s:lmap['A'] = {'name':'TestA'}
  let s:lmap['B'] = {'name':'TestB'}
  let s:lmap['C'] = {'name':'TestC'}
  let s:lmap['D'] = {'name':'TestD'}
  let s:lmap['E'] = {'name':'TestE'}
  let s:lmap['F'] = {'name':'TestF'}
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

  call s:start_buffer()
endfunc


function! s:calc_layout()
  let ret = {}
  let smap = filter(copy(s:lmap), 'v:key !=# "name"')
  let ret.n_items = len(smap)
  let length = values(map(smap,
        \ 'strdisplaywidth("[".v:key."]".'.
        \ '(type(v:val) == type({}) ? v:val["name"] : v:val[1]))'))
  let maxlength = max(length) + g:leaderGuide_hspace
  if g:leaderGuide_vertical
    let ret.n_rows = winheight(0) - 2
    let ret.n_cols = ret.n_items / ret.n_rows + (ret.n_items != ret.n_rows)
    let ret.col_width = maxlength
    let ret.win_dim = ret.n_cols * ret.col_width
  else
    let ret.n_cols = winwidth(0) / maxlength
    let ret.col_width = winwidth(0) / ret.n_cols
    let ret.n_rows = ret.n_items / ret.n_cols + (fmod(ret.n_items,ret.n_cols) > 0 ? 1 : 0)
    let ret.win_dim = ret.n_rows
    "echom string(ret)
  endif
  return ret
endfunction


function! s:create_string(layout)
  echom string(s:lmap)
  let l = a:layout
  let l.capacity = l.n_rows * l.n_cols
  let overcap = l.capacity - l.n_items
  let overh = l.n_cols - overcap
  let n_rows =  l.n_rows - 1

  let rows = []
  let row = 0
  let col = 0
  let smap = sort(filter(keys(s:lmap), 'v:val !=# "name"'),'1')
  for k in smap
    let desc = type(s:lmap[k]) == type({}) ? s:lmap[k].name : s:lmap[k][1]
    let displaystring = "[". k ."] ".desc
    let crow = get(rows, row, [])
    if empty(crow)
      call add(rows, crow)
    endif
    call add(crow, displaystring)
    call add(crow, repeat(' ', l.col_width - strdisplaywidth(displaystring)))

    if !g:leaderGuide_sort_horizontal
      if row >= n_rows - 1
        if overh > 0 && row < n_rows
          let overh -= 1
          let row += 1
        else
          let row = 0
          let col += 1
        endif
      else
        let row += 1
      endif
    else
      if col == l.n_cols - 1
        let row +=1
        let col = 0
      else
        let col += 1
      endif
    endif
    "silent execute "cnoremap <nowait> <buffer> ".substitute(k, "|", "<Bar>", ""). " " . s:escape_keys(k) ."<CR>"
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
  "cnoremap <nowait> <buffer> <Space> <Space><CR>
  "cnoremap <nowait> <buffer> <silent> <C-h> <LGCMD>paging_help<CR>
  return output
endfunction


function! s:escape_keys(inp)
  let ret = substitute(a:inp, "<", "<lt>", "")
  echom string(a:inp) . '->' . string(substitute(ret, "|", "<Bar>", ""))
  return substitute(ret, "|", "<Bar>", "")
endfunction


function! s:wait_for_input()
  echom "not running"
  redraw!
  let inp = input("")
  if inp ==? ''
    let s:prefix_key_inp = ''
    call s:winclose()
    doautocmd WinEnter
  elseif match(inp, "^<LGCMD>paging_help") == 0
    let s:guide_help_mode = 1
    call s:updateStatusline()
    redraw!
    "call s:submode_mappings()
  else
    if inp == ' '
      let inp = '[SPC]'
    endif
    let fsel = get(s:lmap, inp)
    if !empty(fsel)
      let s:prefix_key_inp = inp
      call s:handle_input(fsel)
    else
      let s:prefix_key_inp = ''
      call s:winclose()
      doautocmd WinEnter
    endif
  endif
endfunction

function! s:handle_input(input)
  call s:winclose()
  if type(a:input) ==? type({})
    let s:lmap = a:input
    let s:guide_group = a:input
    call s:start_buffer()
  else
    let s:prefix_key_inp = ''
    call feedkeys(s:vis.s:reg.s:count, 'ti')
    redraw!
    try
      unsilent execute a:input[0]
    catch
      unsilent echom v:exception
    endtry
  endif
endfunction

function! s:updateStatusline() abort
  "call SpaceVim#mapping#guide#theme#hi()
  let gname = get(s:guide_group, 'name', '')
  if !empty(gname)
    let gname = ' - ' . gname[1:]
    let gname = substitute(gname,' ', '\\ ', 'g')
  endif
  let keys = get(s:, 'prefix_key_inp', '')
  let keys = substitute(keys, '\', '\\\', 'g')
  exe 'setlocal statusline=%#LeaderGuiderPrompt#\ Guide:\ ' .
        \ '%#LeaderGuiderSep1#' . s:lsep .
        \ '%#LeaderGuiderName#\ ' .
        \ 'get_name'
        \ . keys . gname
        \ . '\ %#LeaderGuiderSep2#' . s:lsep . '%#LeaderGuiderFill#'
        \ . s:guide_help_msg()

  "exe 'setlocal statusline=%#LeaderGuiderPrompt#\ Guide:\ ' .
  "      \ '%#LeaderGuiderSep1#' . s:lsep .
  "      \ '%#LeaderGuiderName#\ ' .
  "      \ SpaceVim#mapping#leader#getName(s:prefix_key)
  "      \ . keys . gname
  "      \ . '\ %#LeaderGuiderSep2#' . s:lsep . '%#LeaderGuiderFill#'
  "      \ . s:guide_help_msg()

endfunction

function! s:guide_help_msg() abort
  if s:guide_help_mode == 1
    let msg = ' n -> next-page, p -> previous-page, u -> undo-key'
  else
    let msg = ' [C-h paging/help]'
  endif
  return substitute(msg,' ', '\\ ', 'g')
endfunction

