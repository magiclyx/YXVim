"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/06/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:OD = YXVim#lib#import('orderdict')

let s:install_list = s:OD.init()

function! s:regist_installer(name, info)
    if type(a:info) != v:t_dict
        throw 'invalidate plugin info type'
    endif

    let state = {
                \'name' : a:name,
                \'identifier' : '0',
                \'install_fun' : 0,
                \'uninstall_fun' : 0,
                \}

    let install_info = s:OD.get(s:install_list, a:name, {})
    let install_info.identifier = get(a:info, 'identifier', 0)
    let install_info.install_fun = get(a:info, 'install_fun', 0)
    let install_info.uninstall_fun = get(a:info, 'uninstall_fun', 0)
    call s:OD.add(s:install_list, a:name, install_info)

endfunction
