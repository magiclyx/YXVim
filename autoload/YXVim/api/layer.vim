"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:DICT = YXVim#lib#import('dict')
let s:OD = YXVim#lib#import('orderdict')
let s:CONFIG = YXVim#lib#import('config')

let s:layers_state = s:OD.init()


" cb_load() 在layer 配置被加载时调用
" cb_install() 在初次安装或升级时调用(version 信息不同代表升级)
" cb_active 启动后调用
" cb_freshmenu  TODO ！！
function! YXVim#api#layer#setup(name, ...)

  let state = {
        \'name' : a:name,
        \'version' : v:none,
        \'info' : {
            \'display_name':'unknown',
            \'description':'',
            \'active_optional':{}, 
            \'cb_load': v:none,
            \'cb_install': v:none,
            \'cb_active': v:none,
            \'cb_freshmenu': v:none,
        \},
        \'should_active' : v:false,
        \'config_file' : 0,
        \'config_dict' : {},
        \'is_active' : v:false,
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



function! YXVim#api#layer#load_all() abort

  for state in s:OD.values(s:layers_state)
    let file_path = g:Layer_Main_Home . '/' . state.name . '/main.vim'
    call YXVim#api#base#source(file_path)

    if state.should_active
      call YXVim#api#layer#load(state)
    endif

  endfor

endfunction



function! YXVim#api#layer#active_all() abort

  " 取出所有layer的配置信息
  let l:layerConfig = s:CONFIG.sys_config('layer')

  for state in s:OD.values(s:layers_state)
    let file_path = g:Layer_Main_Home . '/' . state.name . '/main.vim'
    " call YXVim#api#base#source(file_path)

    " 取出当前config的配置信息
    let stateInfo = s:CONFIG.get(l:layerConfig, state.name, {})
    " 如果配置信息不存在或版本号同当前layer不同，运行install函数
    if !has_key(stateInfo, 'version') || state.version !=? stateInfo.version

        " 运行install函数
        call YXVim#api#layer#install(state)

        " 保存新的配置信息
        let stateInfo['version'] = state.version
        call s:CONFIG.set(l:layerConfig, state.name, stateInfo)
        call s:CONFIG.synchronize(l:layerConfig)
    endif

    if state.should_active
      call YXVim#api#layer#active(state)
    endif

  endfor

endfunction

"function! YXVim#api#layer#fresh_menu() abort
"
"  " load plugin menu
"  let plugin_menu = YXVim#api#globalmenu#getpluginmenu()
"  for state in s:OD.values(s:layers_state)
"    if len(a:state.name) == 0
"      throw 'invalidate plugin state'
"    endif
"
"    if !empty(a:state)  &&  type(a:state.info.cb_freshmenu) == v:t_func
"      call a:state.info.cb_freshmenu(plugin_menu, bufname('%'), 'plugin')
"    endif
"
"  endfor
"
"
"
"  " load global menu
"  let global_menu = YXVim#api#globalmenu#getmenu()
"  for state in s:OD.values(s:layers_state)
"    if len(a:state.name) == 0
"      throw 'invalidate plugin state'
"    endif
"
"    if !empty(a:state)  &&  type(a:state.info.cb_freshmenu) == v:t_func
"      call a:state.info.cb_freshmenu(plugin_menu, bufname('%'), 'global')
"    endif
"
"  endfor
"  
"
"
"endfunction


function! YXVim#api#layer#install(state) abort

  if len(a:state.name) == 0
    throw 'invalidate plugin state'
  endif

  let plugin_dir = g:Layer_Main_Home . '/' . a:state.name
  
  if !empty(a:state)  &&  type(a:state.info.cb_install) == v:t_func
    call a:state.info.cb_install()
  endif

endfunction


function! YXVim#api#layer#active(state) abort

  if len(a:state.name) == 0
    throw 'invalidate plugin state'
  endif

  let plugin_dir = g:Layer_Main_Home . '/' . a:state.name
  
  if !empty(a:state)  &&  type(a:state.info.cb_active) == v:t_func
    call a:state.info.cb_active()
  endif

  let a:state.is_active = v:true

endfunction


function! YXVim#api#layer#load(state) abort

  if len(a:state.name) == 0
    throw 'invalidate plugin state'
  endif

  let plugin_dir = g:Layer_Main_Home . '/' . a:state.name
  
  execute 'set runtimepath+='.plugin_dir

  if !empty(a:state)  &&  type(a:state.info.cb_load) == v:t_func
    call a:state.info.cb_load()
  endif

endfunction


function! YXVim#api#layer#regist(name, version, info) abort

  if type(a:info) != v:t_dict
    throw 'invalidate plugin info type'
  endif

  let layer_state = s:OD.get(s:layers_state, a:name, {})
  if len(layer_state) != 0
    let layer_state.name = a:name
    let layer_state.version = a:version
    let layer_state.info.display_name = get(a:info, 'display_name', a:name)
    let layer_state.info.description = get(a:info, 'description', layer_state.info.description)
    let layer_state.info.active_optional = get(a:info, 'active_optional', layer_state.info.active_optional)
    let layer_state.info.cb_load = get(a:info, 'cb_load', layer_state.info.cb_load)
    let layer_state.info.cb_install = get(a:info, 'cb_install', layer_state.info.cb_install)
    let layer_state.info.cb_active = get(a:info, 'cb_active', layer_state.info.cb_active)
    let layer_state.info.cb_freshmenu = get(a:info, 'cb_freshmenu', layer_state.info.cb_freshmenu)
    let s:layers_state[a:name] = layer_state
  else
    echom 'unknown layer:' . a:name
  endif

endfunction


function! YXVim#api#layer#list_all() abort

  let layers_path_list = globpath(g:Layer_Main_Home, '*', 0, 1)
  let layers_name_list = []

  for layer_path in layers_path_list

    if ! filereadable(layer_path . '/main.vim')
      continue
    endif

	let layer_name = matchstr(layer_path, '^.*/\zs[a-zA-Z0-9_-]*\ze$')
	if ! empty(layer_name)
      call add(layers_name_list, layer_name)
	endif
  endfor

  return layers_name_list
endfunction


function! YXVim#api#layer#list_setup()
  return s:OD.keys(s:layers_state)
endfunction


function! YXVim#api#layer#list_activate()

  let layers_name_list = []

  for state in s:OD.values(s:layers_state)
    if state.is_active == v:true
      call add(layers_name_list, state.name)
	endif
  endfor

  return layers_name_list
endfunction





