"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/11/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! YXVim#internal#plugins#updatewindow#get() abort
  return map({'show_window' : '',
            \'task_finish' : '',
            \'download_start' : '',
            \'download_done' : '',
            \'download_failed' : '',
            \'download_process' : '',
            \'build_start' : '',
            \'build_done' : '',
            \'build_failed' : '',
            \}, "function('s:' . v:key)")
endfunction

let s:UPDATE_WINDOW_BUFF_NAME = 'YXVimUpdateWindow'
let s:listbuff = YXVim#lib#import('listbuf')
let s:window = 0


" support type :'update', 'install'
function! s:show_window(type, total) abort

  if s:listbuff.buff_exist(s:UPDATE_WINDOW_BUFF_NAME)  &&  s:window.finished
    call s:listbuff.close_buff(s:UPDATE_WINDOW_BUFF_NAME)
    let s:window = 0
  elseif s:listbuff.buff_exist(s:UPDATE_WINDOW_BUFF_NAME)  &&  s:window.type !=# a:type
    throw 'window not finished with ' . a:type
  endif


  if ! s:listbuff.buff_exist(s:UPDATE_WINDOW_BUFF_NAME)
    let s:window = { 'buff' : '',
          \'type' : 0,
          \'finished' : v:false,
          \'total' : 0,
          \'done' : 0,
          \'elapsed' : 0,
          \'plugins' : {},
          \}

    let s:window.buff = s:listbuff.create_buff(s:UPDATE_WINDOW_BUFF_NAME, {'file_type':'YXVimPluginWindow'})
    let s:window.type = a:type
    let s:window.finished = v:false
    let s:window.total = a:total
    let s:window.done = 0
    let s:window.elapsed = 0
    let s:window.plugins = {}

    call s:refresh_title()
  endif

  call s:listbuff.show_buff(s:window.buff)

endfunction


function! s:task_finish(elapsed) abort
  let s:window.finished = v:true
  let s:window.elapsed = a:elapsed
  call s:refresh_title()
endfunction


function! s:refresh_title() abort

  let s:window_title = ''
  let s:window_bar = ''

  if s:window.type ==# 'install'

    if s:window.finished  &&  !empty(s:window.elapsed)
      let s:window_title = 'Installed. Elapsed time: ' . split(reltimestr(s:window.elapsed))[0] . ' sec.'
    else
      let s:window_title = 'Installing plugins (' . s:window.done . '/' . s:window.total . ')'
    endif

  elseif s:window.type ==# 'update'

    if s:window.finished  &&  !empty(s:window.elapsed)
      let s:window_title = 'Updated. Elapsed time: ' . split(reltimestr(s:window.elapsed))[0] . ' sec.'
    else
      let s:window_title = 'Updating plugins (' . s:window.done . '/' . s:window.total . ')'
    endif

  else
    throw 'unknown windows type ' . s:window.type
  endif

  let s:window_bar = '['
  let s:ct = 50 * s:window.done / s:window.total
  let s:window_bar .= repeat('=', s:ct)
  let s:window_bar .= repeat(' ', 50 - s:ct)
  let s:window_bar .= ']'

  call s:listbuff.set_line(s:window.buff, 1, s:window_title)
  call s:listbuff.set_line(s:window.buff, 2, s:window_bar)
  call s:listbuff.set_line(s:window.buff, 3, '')

endfunction


function! s:download_start(name) abort

  if has_key(s:window.plugins, a:name)
    throw 'task ' . a:name . ' already exist'
  endif

  let line_msg = ''
  if s:window.type ==# 'install'
    let line_msg = '+ ' . a:name . ': Installing...'
  elseif s:window.type ==# 'update'
    let line_msg = '+ ' . a:name . ': Updating...'
  else
    throw 'unknown windows type ' . s:window.type
  endif

  let s:window.plugins[a:name] = s:listbuff.append_line(s:window.buff, line_msg)
  call s:refresh_title()

endfunction

function! s:download_done(name) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  let line_msg = ''
  if s:window.type ==# 'install'
    let line_msg = '- ' . a:name . ': Installing done.'
  elseif s:window.type ==# 'update'
    let line_msg = '- ' . a:name . ': Updating done.'
  else
    throw 'unknown windows type ' . s:window.type
  endif


  let s:window.done += 1

  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], line_msg)
  call s:refresh_title()

endfunction

function! s:download_failed(name, ...) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  let detail = '.'
  if a:0 == 1
    let detail = ', ' . a:1
  endif

  let line_msg = ''
  if s:window.type ==# 'install'
    let line_msg = 'x ' . a:name . ': Installing failed' . detail
  elseif s:window.type ==# 'update'
    let line_msg = 'x ' . a:name . ': Updating failed' . detail
  else
    throw 'unknown windows type ' . s:window.type
  endif

  let s:window.done += 1

  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], line_msg)
  call s:refresh_title()

endfunction



function! s:download_process(name, status) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  let line_msg = ''
  if s:window.type ==# 'install'
    let line_msg = '* ' . a:name . ': Installing ' . a:status
  elseif s:window.type ==# 'update'
    let line_msg = '* ' . a:name . ': Updating ' . a:status
  else
    throw 'unknown windows type ' . s:window.type
  endif

  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], line_msg)
  call s:refresh_title()

endfunction


function! s:build_start(name) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], '* ' . a:name . ': Building...')
  call s:refresh_title()

endfunction



function! s:build_done(name) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  let s:window.done += 1
  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], '- ' . a:name . ': Building done.')
  call s:refresh_title()

endfunction



function! s:build_failed(name, ...) abort

  if !has_key(s:window.plugins, a:name)
    throw 'unknown task ' . a:name
  endif

  let detail = '.'
  if a:0 == 1
    detail = ', ' . a:1
  endif

  let s:window.done += 1

  call s:listbuff.set_line(s:window.buff, s:window.plugins[a:name], 'x ' . a:name . ': Building failed' . detail)
  call s:refresh_title()

endfunction



