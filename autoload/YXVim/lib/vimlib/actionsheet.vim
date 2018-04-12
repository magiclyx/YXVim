"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/01/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#vimlib#actionsheet#get() abort
    return map({
          \'show' : '',
          \'close' : '',
          \'set_filetype' : '',
          \'set_content' : '',
          \'set_title' : '',
          \},
          \"function('s:' . v:key)"
          \)
endfunction


let s:current_window = v:none

function! s:show(pos, string, size, attribute) abort

  if bufexists(s:current_window)
    return
  endif

  let position = 'botright'
  let opencmd = ''
  if a:pos ==# 'bottom'
    let position = 'botright'
    let opencmd = ''
  elseif a:pos ==# 'top'
    let position = 'topleft'
    let opencmd = ''
  elseif a:pos ==# 'right'
    let position = 'rightbelow'
    let opencmd = 'vertical'
  elseif a:pos ==# 'left'
    let position = 'topleft'
    let opencmd = 'vertical'
  endif

  if type(a:attribute) != v:t_dict
    let attribute = {}
  endif


  " init current_window
  let s:current_window = {}

  " set action sheet info
  let s:current_window.position = position
  let s:current_window.opencmd = opencmd
  let s:current_window.size = a:size
  let s:current_window.string = a:string
  let s:current_window.filetype = get(a:attribute, 'filetype', v:none)
  let s:current_window.title = get(a:attribute, 'title', v:none)

  " init buffer context
  let s:current_window.bufnr = -1
  let s:current_window.winnr = -1

  " store current window context
  let s:current_window.buckup = {}
  let s:current_window.buckup.win_info = winsaveview()
  let s:current_window.buckup.win_num =  winnr()
  let s:current_window.buckup.win_size = winrestcmd()


  call s:winopen(s:current_window)
  call s:set_title(s:current_window, s:current_window.title)
  call s:set_content(s:current_window, s:current_window.string, s:current_window.size) 
  call s:toggle_hide_cursor(s:current_window)

  "if empty(maparg("<c-c>", "c", 0, 1))
  "  execute 'cnoremap <nowait> <silent> <buffer> <c-c> <esc>'
  "endif

endfunction




function! s:set_filetype(sheet, filetype)
  let a:sheet.filetype = a:filetype
  setlocal filetype=a:sheet.filetype

  if a:sheet.filetype != v:none
    execute 'setlocal filetype=' . a:sheet.filetype
    "redraw!
  endif
endfunction


function! s:set_content(sheet, string, size)

  let a:sheet.string = a:string
  let a:sheet.size = a:size

  setlocal modifiable
  noautocmd execute a:sheet.opencmd . ' resize '. a:size
  "silent 1put!=a:string
  silent call append(0, a:string)
  normal! _dd
  "normal! gg"_dd
  setlocal nomodifiable

  "redraw!
endfunction


function! s:set_title(sheet, title)
  call s:updateStatusline(a:sheet)
endfunction


function! s:close()

  if type(s:current_window) == v:t_none
    return
  endif

  call s:toggle_hide_cursor(s:current_window)

  if s:current_window.win_num == winnr()
    noautocmd close
    redraw!
    execute s:current_window.buckup.win_size
    noautocmd execute s:current_window.buckup.win_num.'wincmd w'
    call winrestview(s:current_window.buckup.win_info)
    let s:current_window = v:none
  endif

endfunction



function! s:winopen(sheet)

  noautocmd execute a:sheet.position . ' ' . a:sheet.opencmd . a:sheet.size . 'new'
  "noautocmd execute a:sheet.position . ' ' . a:sheet.size . a:sheet.opencmd

  let a:sheet.bufnr = bufnr('%')
  let a:sheet.win_num = winnr()
  echom 'window number:' . a:sheet.winnr
  autocmd WinLeave <buffer> call s:close()

  if a:sheet.filetype != v:none
    execute 'setlocal filetype=' . a:sheet.filetype
  endif

  setlocal nonumber norelativenumber nolist nomodeline nowrap
  setlocal nobuflisted buftype=nofile bufhidden=unload noswapfile
  setlocal nocursorline nocursorcolumn colorcolumn=
  setlocal winfixwidth winfixheight

endfunction



function! s:toggle_hide_cursor(sheet) abort
  return
  if !exists('a:sheet.buckup.cursor')
    let a:sheet.buckup.cursor = ''
  endif

  let t_ve = &t_ve
  let &t_ve = a:sheet.buckup.cursor
  let a:sheet.buckup.cursor = t_ve
endfunction


function! s:updateStatusline(sheet) abort
  if a:sheet.title == v:none
    return
  endif

  execute 'setlocal statusline=' . a:sheet.title
endfunction



