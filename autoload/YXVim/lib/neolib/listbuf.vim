"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/09/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:bufs = {}


function! YXVim#lib#vimlib#listbuf#get() abort
  return map({'create_buff' : '',
            \'close_buff' : '',
            \'buff_exist' : '',
            \'show_buff' : '',
            \'set_line' : '',
            \'append_line' : '',
            \}, "function('s:' . v:key)")
endfunction

function! s:buff_exist(name) abort
  return has_key(s:bufs, a:name)
endfunction

function! s:create_buff(name, ...) abort

  if has_key(s:bufs, a:name)
    call s:show_buff()
    return s:bufs[a:name]
  endif

  let s:buff = {
        \'name' : a:name,
        \'buff' : 0,
        \'type' : 0,
        \'lines' : [],
        \'win_cmd' : 'vertical topleft new',
        \'file_type' : 0,
        \}

  if a:0 > 0  &&  type(a:1) == v:t_dict
    let s:buff['win_cmd'] = get(a:1, 'win_cmd', s:buff.win_cmd)
    let s:buff['file_type'] = get(a:1, 'file_type', s:buff.file_type)
  endif


  return s:buff

endfunction



function! s:close_buff(name) abort

  if ! has_key(s:bufs, a:name)
    return
  endif

  let buff = s:bufs[a:name]

  if buff.buff != 0 && bufexists(buff.buff)
    execute ':bwipeout! ' . buff.buff
  endif

  call remove(s:bufs, a:name)

endfunction


function! s:show_buff(buff) abort
  if a:buff.buff != 0 && bufexists(a:buff.buff)
    " buffer exist, process has not finished!
    return 0
  elseif a:buff.buff != 0 && !bufexists(a:buff.buff)
    " buffer is hidden, process has not finished!
    call s:resume_buff(a:buff)
    return 1
  else
    execute a:buff.win_cmd
    "execute 'vertical split topleft new'
    let a:buff.buff = bufnr('%')
    setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nospell
    if len(a:buff.file_type) > 0
      execute 'setfiletype ' . a:buff.file_type
    endif

    python import vim
    py bufnr = string.atoi(vim.eval("a:buff.buff"))

    let numlines=pyeval('len(vim.buffers[bufnr])')

    if len(a:buff.lines) != 0
      let numlines=pyeval('len(vim.buffers[bufnr])')
      call setline(1, a:buff.lines)
      let numlines=pyeval('len(vim.buffers[bufnr])')
    endif

    setlocal nomodifiable 

    call s:check(a:buff, 'after create buff')

    return 2
  endif
endfunction


function! s:resume_buff(buff) abort
  execute a:buff.win_cmd

  let a:buff.buff = bufnr('%')
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nospell
    if len(a:buff.file_type) > 0
      execute 'setfiletype ' . a:buff.file_type
    endif

  call setline(1, a:buff.lines)
  setlocal nomodifiable 
endfunction



" change modifiable before setline
if has('python')
  py import vim
  py import string
  " @vimlint(EVL103, 1, a:nr)
  " @vimlint(EVL103, 1, a:line)
  function! s:set_line(buff, nr, line) abort

    call s:check(a:buff, 'set_line 入口')

    let s:need_append_blank_line = a:nr - len(a:buff.lines)
    if s:need_append_blank_line < 0
      let s:need_append_blank_line = 0
    endif


    if bufexists(a:buff.buff)

      py bufnr = string.atoi(vim.eval("a:buff.buff"))
      py linr = string.atoi(vim.eval("a:nr")) - 1
      py str = vim.eval("a:line")

      call setbufvar(a:buff.buff,'&ma', 1)
      let s:index = 0
      while s:index < s:need_append_blank_line
        py vim.buffers[bufnr].append('')
        let s:index += 1
      endwhile
      py vim.buffers[bufnr][linr] = str
      call setbufvar(a:buff.buff,'&ma', 0)

    endif

    let s:index = 0
    while s:index < s:need_append_blank_line
      call add(a:buff.lines, '\n')
      let s:index += 1
    endwhile

    let a:buff.lines[a:nr - 1] = a:line
    call s:check(a:buff, 'set_line 出口')

  endfunction

  function! s:append_line(buff, line) abort

    call s:check(a:buff, 'append_line 入口: '. a:line)

    if bufexists(a:buff.buff)

      py bufnr = string.atoi(vim.eval("a:buff.buff"))
      py str = vim.eval("a:line")

      call setbufvar(a:buff.buff,'&ma', 1)
      if len(a:buff.lines) == 0  &&  line('$') == 1
        py vim.buffers[bufnr][0] = str
      else
        py vim.buffers[bufnr].append(str)
      endif
      call setbufvar(a:buff.buff,'&ma', 0)

    endif

    call add(a:buff.lines, a:line)

    call s:check(a:buff, 'append_line 出口')
    return len(a:buff.lines)

  endfunction
  " @vimlint(EVL103, 0, a:bufnr)
  " @vimlint(EVL103, 0, a:nr)
  " @vimlint(EVL103, 0, a:line)
else

  function! s:focus_main_win(buff) abort
    let winnr = bufwinnr(a:buff.buff)
    if winnr > -1
      exe winnr . 'wincmd w'
    endif
    return winnr
  endfunction

  function! s:set_line(buff, nr, line) abort

    let s:need_append_blank_line = a:nr - len(a:buff.lines)
    if s:need_append_blank_line < 0
      let s:need_append_blank_line = 0
    endif

    if bufexists(a:buff.buff)
      if s:focus_main_win() >= 0
        call setbufvar(a:buff.buff,'&ma', 1)
        let s:index = 0
        while s:index < s:need_append_blank_line
          call append(line('$'), '\n')
          let s:index += 1
        endwhile

        call setline(a:nr, a:line)
        call setbufvar(a:buff.buff,'&ma', 0)
      endif
    endif

    let s:index = 0
    while s:index < s:need_append_blank_line
      call add(a:buff.lines, '')
      let s:index += 1
    endwhile

    let a:buff.lines[a:nr - 1] = a:line

  endfunction

  function! s:append_line(buff, line) abort

    if bufexists(a:buff.buff)
      if s:focus_main_win() >= 0

        call setbufvar(a:buff.buff,'&ma', 1)
        if len(a:buff.lines) == 0  &&  line('$') == 1
          call setline(0, a:line)
        else
          call append(line('$'), a:line)
        endif
        call setbufvar(a:buff.buff,'&ma', 0)

      endif
    endif

    call add(a:buff.lines, a:line)

    return len(a:buff.lines)

  endfunction

endif


function! s:check(buff, msg)

    return

    if bufexists(a:buff.buff)
      py import vim
      py import string

      py bufnr = string.atoi(vim.eval("a:buff.buff"))
      let ss = pyeval('string.atoi(vim.eval("a:buff.buff"))')

      echom '~~~~~~~~~~~~>' . a:msg
      echom ss
      py print(bufnr)
      let lines_in_list = len(a:buff.lines)
      let lines_in_buff = pyeval('len(vim.buffers[bufnr])')

      if lines_in_list != lines_in_buff
        echom 'buf=' . lines_in_list . '  list=' . lines_in_buff
        throw 'buff line differented buf=' . lines_in_buff . 'list=' . lines_in_list
      else
        echom 'done'
      endif

      echom '~~~~~~~~~~~<-'
    endif

endfunction

