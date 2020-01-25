"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/25/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


let g:vim_json_syntax_conceal = get(g:, 'vim_json_syntax_conceal', o)


function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun


"command! JsonFormat :execute '%!python -m json.tool'
"\ | :execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'
"\ | :set ft=javascript
"\ | :
"
function s:json_format()

    " format file
    execute '%!python -m json.tool'
    \ | :execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'
    \ | :set ft=javascript
    \ | :

    " force set filetype back to json
    set ft=json
endfunction



let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_command(s:menu, 'Format', 'f', 'call <SNR>' . s:SID() . '_json_format()')

call YXVim#api#optmenu#regist('json', s:menu)


"au BufRead,BufNewFile *.json set filetype=json
"au! Syntax json source /Users/brad/.vim/ftplugin/json.vim

