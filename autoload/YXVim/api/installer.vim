"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/06/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

let s:OD = YXVim#lib#import('orderdict')

let s:installer_list = s:OD.init()



function! YXVim#api#installer#findall() abort
  let layers_path_list = globpath(g:Layer_Main_Home, '*', 0, 1)

  for layer_path in layers_path_list
    if ! filereadable(layer_path . '/main.vim')
      continue
    endif

    let s:installer_path = layer_path . '/installer.vim'
    if ! filereadable(s:installer_path)
      continue
    endif

    call YXVim#api#base#source(s:installer_path)

  endfor

endfunction



function! YXVim#api#installer#regist(name, info) abort
    if type(a:info) != v:t_dict
        throw 'invalidate plugin info type'
    endif

    let state = {
                \'name' : a:name,
                \'identifier' : '0',
                \'install_fun' : 0,
                \'uninstall_fun' : 0,
                \'is_install' : v:false,
                \}

    let install_info = s:OD.get(s:install_list, a:name, {})
    let install_info.identifier = get(a:info, 'identifier', 0)
    let install_info.install_fun = get(a:info, 'install_fun', 0)
    let install_info.uninstall_fun = get(a:info, 'uninstall_fun', 0)
    call s:OD.add(s:install_list, a:name, install_info)

endfunction


function! YXVim#api#installer#getall() abort
  return deepcopy(s:OD.values(s:installer_list))
endfunction

function! YXVim#api#installer#install(installer) abort
  if type(installer.install_fun) == v:t_func
    call installer.install_fun()
  endif
endfunction

function! YXVim#api#installer#uninstall(installer) abort
  if type(installer.uninstall_fun) == v:t_func
    call installer.uninstall_fun()
  endif
endfunction



