"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/01/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echom "load test script"


"let s:layers_list = globpath(g:Layer_Main_Home, '*', 0, 1)
"echo s:layers_list
"echo s:layers_list[0]
"
"for layer_path in s:layers_list
"  let layer_name = matchstr(layer_path, '^.*/\zs[a-zA-Z0-9_-]*\ze$')
"  if ! empty(layer_name)
"    echom layer_name
"  endif
"endfor


echo YXVim#api#layer#list_all()
echo YXVim#api#layer#list_setup()
echo YXVim#api#layer#list_activate()

