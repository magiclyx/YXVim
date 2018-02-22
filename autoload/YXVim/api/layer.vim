"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:DICT = YXVim#lib#import('dict')
let s:OD = YXVim#lib#import('orderdict')

let s:layers_state = s:OD.init()


function! YXVim#api#layer#setup(name, ...)

  let state = {
        \'name' : a:name,
        \'info' : {},
        \'should_active' : v:false,
        \'config_file' : 0,
        \'config_dict' : {},
        \'is_active' : {},
        \}

  if a:0 >= 1
    if type(a:1) == v:t_bool
      let state.should_active = a:1
    elseif type(a:1) == v:t_dict
      let state.config_dict = a:1
    endif
  endif

  if a:0 >= 2
    if type(a:2) == v:t_dict
      let state.config_dict = a:2
    endif
  endif

  let state.config_file = s:DICT.get(state.config_dict, 'config_file', v:t_dict, 0)

  call s:DICT.remove(state.config_dict, 'config_file')

  call s:OD.add(s:layers_state, a:name, state)

endfunction



function! YXVim#api#layer#load() abort

  for state in s:OD.values(s:layers_state)
    let file_path = g:Layer_Main_Home . '/' . state.name . '/main.vim'
    call YXVim#api#base#source(file_path)

    if state.should_active
      call YXVim#api#layer#activate(state)
    endif

  endfor

endfunction


function! YXVim#api#layer#activate(state) abort

  if len(a:state.name) == 0
    throw 'invalidate plugin state'
  endif

  let plugin_dir = g:Layer_Main_Home . '/' . a:state.name
  
  if type(a:state.info.cb_willActive) == v:t_func
    call a:state.info.cb_willActive()
  endif

  execute 'set runtimepath+='.plugin_dir

  if type(a:state.info.cb_didActive) == v:t_func
    call a:state.info.cb_didActive()
  endif

endfunction


function! YXVim#api#layer#regist(name, info) abort

  if type(a:info) != v:t_dict
    throw 'invalidate plugin info type'
  endif

  let layer_state = s:OD.get(s:layers_state, a:name, {})

  let layer_state.info.display_name = get(a:info, 'display_name', a:name)
  let layer_state.info.description = get(a:info, 'description', '')
  let layer_state.info.active_optional = get(a:info, 'active_optional', {})
  let layer_state.info.cb_willActive = get(a:info, 'cb_willActive', 0)
  let layer_state.info.cb_didActive = get(a:info, 'cb_didActive', 0)

endfunction



