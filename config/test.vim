"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 03/08/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echom 'test!test!'


let s:actionsheet = YXVim#lib#import('actionsheet')


let s:sheet = v:none

function! s:test()

  let s:sheet = s:actionsheet.show('bottom', 'lalal', 10, {'filetype':'abc', 'title':'Title'})

  "call s:actionsheet.show(s:sheet)

endfunction


function! s:test2()
  call s:actionsheet.close()
endfunction


command! OPEN call s:test()
command! CLOSE call s:test2()


