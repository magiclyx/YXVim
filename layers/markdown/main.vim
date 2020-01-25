"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/25/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:VERSION = '2.0.0'
let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))


function! s:cb_load() abort
    echo "fafafa"

  " tabular 文本对齐插件，vim-markdown必须安装
  call YXVim#api#plugin#add('godlygeek/tabular')
  " markdown 插件
  call YXVim#api#plugin#add('plasticboy/vim-markdown')


  " 可选 一个自动在当前光标生成目录的插件
  call YXVim#api#plugin#add('mzlogin/vim-markdown-toc')

  " 预览插件，如果需要预览数学公式, 需要安装这个
  call YXVim#api#plugin#add('iamcco/mathjax-support-for-mkdp')
  " 预览用的
  call YXVim#api#plugin#add('iamcco/markdown-preview.vim')

  " add all config 
  call YXVim#api#base#source(s:_current_file_dir.'/markdown.vim')

endfunction


call YXVim#api#layer#regist('markdown', s:VERSION, 
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})




