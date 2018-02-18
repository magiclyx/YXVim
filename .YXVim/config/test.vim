"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/01/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echom "kkk"


"function s:test()
"  return map({
"        \ 'execute' : '',
"        \ 'system' : '',
"        \ 'systemlist' : '',
"        \ 'version' : '',
"        \ 'has' : '',
"        \ 'globpath' : '',
"        \ },
"        \ "function('s:' . v:key)"
"        \ )
"endfunction


let dd = {
    \ 'execute' : '',
    \ 'system' : '',
    \ 'systemlist' : '',
    \ 'version' : '',
    \ 'has' : '',
    \ 'globpath' : '',
    \ }



let output = systemlist('ls')
echo output

"echo map(, '"> " . v:key . " <"')



let g:spacevim_plugin_manager = 'dein'
let g:spacevim_plugin_manager_max_processes = 8
let g:spacevim_plugin_bundle_dir = g:Support_Main_Home.'/dein'


command! -nargs=*
      \ SPUpdate call <SID>update_plugin(<f-args>)

""
" Command for reinstall plugin, support completion of plugin name. 
command! -nargs=+
      \ SPReinstall call <SID>reinstall_plugin(<f-args>)

""
" Command for install plugins.
command! -nargs=* SPInstall call <SID>install_plugin(<f-args>)


let s:manager = YXVim#lib#import('manager')

function! s:update_plugin(...) abort
    if a:0 == 0
      call s:manager.update()
    else
      call s:manager.update(a:000)
    endif
endfunction

function! s:reinstall_plugin(...)
  call s:manager.reinstall(a:000)
endfunction

function! s:install_plugin(...) abort
    if a:0 == 0
      call s:manager.install()
    else
      call dein#install(a:000)
    endif
endfunction


