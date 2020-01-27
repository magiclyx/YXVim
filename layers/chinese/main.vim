"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0.0 - 02/17/2018 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 版本号
let s:VERSION = '2.0.0'

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

function! s:cb_load() abort
  "main doc
  call YXVim#api#plugin#add('vimcn/vimcdoc')


  "taglist.vim 中文文档
  call YXVim#api#plugin#add('vimcn/taglist.vim.cnx')
  "NERD_tree.vim 中文文档
  call YXVim#api#plugin#add('vimcn/NERD_tree.vim.cnx')
  "NERD_commenter 中文文档
  call YXVim#api#plugin#add('vimcn/NERD_commenter.cnx')
  "tagbar: Display tags of the current file ordered by scope
  call YXVim#api#plugin#add('vimcn/tagbar.cnx')
  "mru.vim 中文文档
  call YXVim#api#plugin#add('vimcn/mru.vim.cnx')
  
  


  "Should.js documentation in vim doc.
  "call YXVim#api#plugin#add('vimcn/should.js.txt')
  "
  "Node API doc in Vim help doc
  "call YXVim#api#plugin#add('vimcn/node-vimdoc')
  "
  "Vundle 中文文档
  "call YXVim#api#plugin#add('vimcn/vundle.cnx')

  "fugitive.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/fugitive.cnx')

  "ctrlp.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/ctrlp.cnx')

  "C/C++ IDE -- Write and run programs. Insert statements, idioms, comments etc.
  "call YXVim#api#plugin#add('vimcn/c.vim.cnx')

  "https://github.com/scrooloose/syntastic 中文文档
  "call YXVim#api#plugin#add('vimcn/syntastic.cnx')

  "NEOCompleteCache 中文文档
  "call YXVim#api#plugin#add('vimcn/neocompletecache.cnx')
  
  "Manage wordpress blog posts from Vim
  "call YXVim#api#plugin#add('vimcn/vimpress.cnx')

  "textile doc for vim
  "call YXVim#api#plugin#add('vimcn/textile.vim')

  "matchit.vim 中文文档。
  "call YXVim#api#plugin#add('vimcn/matchit.vim.cnx')

  "bufexplorer.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/bufexplorer.vim.cnx')

  "snipMate.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/snipMate.vim.cnx')

  "twitvim.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/twitvim.vim.cnx')

  "project.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/project.vim.cnx')
  "
  "AutoComplPop.vim 中文文档
  "call YXVim#api#plugin#add('vimcn/acp.vim.cnx')
  
  "Git manual in vim doc.
  "call YXVim#api#plugin#add('vimcn/git.vim')

endfunction


call YXVim#api#layer#regist('chinese', s:VERSION,
      \ {
        \ 'cb_load':function('s:cb_load'),
      \})



