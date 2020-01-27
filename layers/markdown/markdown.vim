"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/25/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markddown 相关配置
" optional here
" https://github.com/plasticboy/vim-markdown

" support Latex数学公式高亮
let g:tagbar_width = get(g:, 'vim_markdown_math', 1)

" 允许TOC窗口自动缩小到合适大小
let g:vim_markdown_toc_autofit = get(g:, 'vim_markdown_toc_autofit', 1)

" 禁用折叠
" let g:vim_markdown_folding_disabled = get(g:, 'vim_markdown_folding_disabled', 1)


" 使用python-mode风格的折叠
let g:vim_markdown_folding_style_pythonic = get(g:, 'vim_markdown_folding_style_pythonic', 1)


" markdown 是否支持多行(默认时支持)
" let g:vim_markdown_emphasis_multiline = get(g:, 'vim_markdown_emphasis_multiline', 1)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown-toc 相关配置
" https://mazhuang.org/2015/12/19/vim-markdown-toc/

" 取消存储时自动更新目录
let g:vmt_auto_update_on_save = get(g:, 'vmt_auto_update_on_save', 1)



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview.vim 相关配置
" https://github.com/iamcco/markdown-preview.nvim


" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
" 如果设置了该参数, g:mkdp_browserfunc 将被忽略
" let g:mkdp_path_to_chrome = get(g:, 'mkdp_path_to_chrome', 'firefox')


" vim 回调函数, 指定要打开的url
" let g:mkdp_browserfunc = get(g:, 'MKDP_browserfunc_default', '')


" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
" markdown 文件的时候打开一次
" let g:mkdp_auto_start = get(g:, 'mkdp_auto_start', 1)


" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预
" 览窗口
" let g:mkdp_auto_open = get(g:, 'mkdp_auto_open', 1)


" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
" 自动关闭预览窗口
let g:mkdp_auto_close = get(g:, 'mkdp_auto_close', 1)


" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
" 更新预览
" let g:mkdp_refresh_slow = get(g:, 'mkdp_auto_close', 0)


" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
" 文件可以使用改命令
let g:mkdp_command_for_global = get(g:, 'mkdp_command_for_global', 1)


" 设置为 1, 在使用的网络中的其他计算机也能访问预览页面
" 默认只监听本地（127.0.0.1），其他计算机不能访问
let g:mkdp_open_to_the_world = get(g:, 'mkdp_command_for_global', 1)


" 在命令行中，回显url
let g:mkdp_echo_preview_url = get(g:, 'mkdp_command_for_global', 1)






function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun


" 解决删除Toc过深的问题
function s:SimpleTOC()
    exe "/-toc .* -->"
    let lstart=line('.')
    exe "/-toc -->"
    let lnum=line('.')
    execute lstart.",".lnum."g/           /d"

    echom 'fuck fuck fuck fuck'

    " 一旦使用这个选项, 必须关闭推出自动更新TOC的情况
    let g:vmt_auto_update_on_save = 0
endfunction




let s:LEADERMENU = YXVim#lib#import('leadermenu')

let s:menu = s:LEADERMENU.create_menu()

" call s:LEADERMENU.set_command(s:menu, 'Fold all', 'fa', ':normal zM')
" call s:LEADERMENU.set_command(s:menu, 'Unfold all', 'ua', ':normal zR')
" call s:LEADERMENU.set_command(s:menu, 'Fold level +', 'ff', ':normal zm')
" call s:LEADERMENU.set_command(s:menu, 'Fold level -', 'uu', ':normal zr')
" call s:LEADERMENU.set_command(s:menu, 'Fold cursor', 'fc', ':normal za')
" call s:LEADERMENU.set_command(s:menu, 'Unfold cursor', 'uc', ':normal zc')


let s:fold_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:menu, 'Fold', 'f', s:fold_menu)

call s:LEADERMENU.set_command(s:fold_menu, 'Fold all', 'fa', ':normal zM')
call s:LEADERMENU.set_command(s:fold_menu, 'Unfold all', 'ua', ':normal zR')
call s:LEADERMENU.set_command(s:fold_menu, 'Fold level +', 'ff', ':normal zm')
call s:LEADERMENU.set_command(s:fold_menu, 'Fold level -', 'uu', ':normal zr')
call s:LEADERMENU.set_command(s:fold_menu, 'Fold cursor', 'fc', ':normal za')
call s:LEADERMENU.set_command(s:fold_menu, 'Unfold cursor', 'uc', ':normal zc')


let s:toc_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:menu, 'Toc', 't', s:toc_menu)

call s:LEADERMENU.set_command(s:toc_menu, 'Add Toc', 'am', 'GenTocMarked')
call s:LEADERMENU.set_command(s:toc_menu, 'Add Toc(GitHub)', 'ah', 'GenTocGFM')
call s:LEADERMENU.set_command(s:toc_menu, 'Add Toc(GitLab)', 'al', 'GenTocGitLab')
call s:LEADERMENU.set_command(s:toc_menu, 'Add Toc(Redcarpet)', 'ar', 'GenTocRedcarpet')
call s:LEADERMENU.set_command(s:toc_menu, 'Update Toc', 'u', 'UpdateToc')
call s:LEADERMENU.set_command(s:toc_menu, 'Update Toc', 'd', 'RemoveToc')
" call s:LEADERMENU.set_command(s:toc_menu, 'Simple Toc', 's', 'call __SimpleTOC()')
call s:LEADERMENU.set_command(s:toc_menu, 'Simple Toc', 's', 'call <SNR>' . s:SID() . '_SimpleTOC()')



let s:preview_menu = s:LEADERMENU.create_menu()
call s:LEADERMENU.set_submenu(s:menu, 'Preview', 'p', s:preview_menu)
call s:LEADERMENU.set_command(s:preview_menu, 'Start', 'on', 'MarkdownPreview')
call s:LEADERMENU.set_command(s:preview_menu, 'Stop', 'off', 'MarkdownPreviewStop')


call YXVim#api#optmenu#regist('markdown', s:menu)

" function! s:tttt()
"    call YXVim#api#base#source(s:_current_file_dir.'/test.vim')
" endfunction

" nnoremap <leader>s :call <SID>tttt()<CR>

" command! -nargs=*
"       \ -complete=custom,s:complete_plugin
"       \ YXUpdate call <SID>update_plugin(<f-args>)


augroup YXMarkdown
  autocmd!
  autocmd Filetype markdown nmap <buffer> <silent> <F2> :Toc<CR>
augroup END
