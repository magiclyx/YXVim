"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! YXVim#lib#vimlib#config#get() abort
  return map({
        \'config' : '',
        \'set' : '',
        \'get' : '',
        \'synchronize' : '',
        \}, "function('s:' . v:key)")
endfunction




let s:serialize = YXVim#lib#import('serialize')

let s:config_dir = g:Data_Home . '/config'
if finddir(s:config_dir) ==# ''
    silent call mkdir(s:config_dir)
endif



let g:config_cache = {}


function! s:config(key)
  
  " load specific config
  call s:load(a:key)
  
  " fetch config
  let config_dict = get(g:config_cache, a:key, {})
  if len(config_dict) == 0
    let config_dict.name = a:key
    let config_dict.config = {}
    let config_dict.should_sync = v:false
    let g:config_cache[a:key] = config_dict
  endif

  return config_dict
endfunction


function! s:synchronize(config)
  if type(a:config) != v:t_dict  ||  len(a:config) == 0
    throw 'invalidate config parameter'
  endif

  if len(a:config.config) == 0
    return
  endif

  if a:config.should_sync
    call s:serialize.To(a:config.config, s:config_dir . '/' . a:config.name)
    let a:config.should_sync = v:false
  endif
endfunction


function! s:set(config, key, val)
  if type(a:config) != v:t_dict  ||  len(a:config) == 0
    throw 'invalidate config parameter'
  endif

  let a:config.config[a:key] = a:val
  let a:config.should_sync = v:true
endfunction


function! s:get(config, key, ...)
  if type(a:config) != v:t_dict  ||  len(a:config) == 0
    throw 'invalidate config parameter'
  endif
  
  let default_value = 0
  if a:0 > 0
    let default_value = a:1
  endif
  
  return get(a:config.config, a:key, default_value)
endfunction


function! s:load(key)
 
  let file_path = s:config_dir . '/' . a:key
  if filewritable(file_path)
    let config_dict = {}
    let config_dict.name = a:key
    let config_dict.config = s:serialize.From(s:config_dir . '/' . a:key)
    let config_dict.should_sync = v:false
    let g:config_cache[a:key] = config_dict
  else
    let config_dict = {}
    let config_dict.name = a:key
    let config_dict.config = {}
    let config_dict.should_sync = v:false
    let g:config_cache[a:key] = config_dict
  end
endfunction



"let s:myConfig = s:config('test')
"call s:set(s:myConfig, 'tt', {'a':1, 'b':2})
"call s:set(s:myConfig, 'nn', ['a', 'b', 'c'])

"call s:synchronize(s:myConfig)

"echom string(s:myConfig)

"echom type(s:get(s:myConfig, 'tt'))
"echom type(s:get(s:myConfig, 'nn'))



