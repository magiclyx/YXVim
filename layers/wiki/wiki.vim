"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/28/2020

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:_current_file_path = resolve(expand('<sfile>:p'))
let s:_current_file_dir = resolve(expand('<sfile>:p:h'))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add 3 wiki here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
 " {{{c++
 " #include \"helloworld.h\"
 " int helloworld()
 " {
 "    printf("hello world");
 " }
 " }}}
"
let s:syntaxes = {'asm': 'asm', 'c': 'c', 'c++': 'cpp','java': 'java', 'lua': 'lua', 'perl': 'perl', 'python': 'python', 'html': 'html', 'xml': 'xml', 'javascript': 'javascript', 'bash': 'sh', 'vim': 'vim', 'make': 'make', 'automake': 'automake', 'objc':'objc', 'go':'go', 'css':'css', 'csc':'csc', 'less':'less', 'ruby':'ruby', 'sql':'sql', 'html-django':'htmldjango', 'man':'man', 'svg':'svg', 'xhtml':'xhtml', 'yaml':'yaml'}
"
" default wiki
let s:default_wiki_dir = get(g:, 'VIMWIKI_PATH', g:Data_Home.'/wiki/default')

let s:default_wiki_path = {}
let s:default_wiki_path.path = s:default_wiki_dir . '/wiki'
let s:default_wiki_path.path_html = s:default_wiki_dir . '/html'
let s:default_wiki_path.nested_syntaxes = s:syntaxes
let s:default_wiki_path.automatic_nested_syntaxes = 0 "[slow] syntax when open a buff
let s:default_wiki_path.auto_export = 0 "auto export to html
let s:default_wiki_path.auto_toc = 0 "auto update toc when save
let s:default_wiki_path.auto_toc = 0 "auto update toc when save
"let s:default_wiki_path.syntax = 'markdown' "wiki syntax. 如果设为markdown, 则无法自动转换为html. 可选值为 default, markdown(Markdown), or media(MediaWiki)
let s:default_wiki_path.ext = '.md' "Extension of iki
let s:default_wiki_path.maxhi = 0 "wiki links to non-existent wiki files are highlighted. However it can be quite slow


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" private wiki
let s:private_wiki_dir = get(g:, 'VIMWIKI_PATH', g:Data_Home.'/wiki/private')
 
let s:private_wiki_path = {}
let s:private_wiki_path.path = s:private_wiki_dir . '/wiki'
let s:private_wiki_path.path_html = s:private_wiki_dir . '/html'
let s:private_wiki_path.nested_syntaxes = s:syntaxes
let s:private_wiki_path.automatic_nested_syntaxes = 0 "[slow] syntax when open a buff
let s:private_wiki_path.auto_export = 0 " auto export to html
let s:private_wiki_path.auto_toc = 0 "auto update toc when save
"let s:private_wiki_path.syntax = 'markdown' "wiki syntax. 如果设为markdown, 则无法自动转换为html. 可选值为 default, markdown(Markdown), or media(MediaWiki)
let s:private_wiki_path.ext = '.md' "Extension of iki
let s:private_wiki_path.maxhi = 0 "[slow]wiki links to non-existent wiki files are highlighted. 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" job wiki
let s:job_wiki_dir = get(g:, 'VIMWIKI_PATH', g:Data_Home.'/wiki/private')

let s:job_wiki_path = {}
let s:job_wiki_path.auto_export = 0
let s:job_wiki_path.path = s:job_wiki_dir . '/wiki'
let s:job_wiki_path.path_html = s:job_wiki_dir . '/html'
let s:job_wiki_path.nested_syntaxes = s:syntaxes
let s:job_wiki_path.automatic_nested_syntaxes = 0 "[slow] syntax when open a buff
let s:job_wiki_path.auto_export = 0 " auto export to html
let s:job_wiki_path.auto_toc = 0 "auto update toc when save
"let s:job_wiki_path.syntax = 'markdown' "wiki syntax. 如果设为markdown, 则无法自动转换为html. 可选值为 default, markdown(Markdown), or media(MediaWiki)
let s:job_wiki_path.ext = '.md' "Extension of iki
let s:job_wiki_path.maxhi = 0 "wiki links to non-existent wiki files are highlighted. However it can be quite slow


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = get(g:, 'vimwiki_list', [s:default_wiki_path, s:private_wiki_path, s:job_wiki_path])
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Convert directory name from current 'encoding' into 'g:vimwiki_w32_dir_enc' before it is created.
let g:vimwiki_w32_dir_enc = get(g:, 'vimwiki_w32_dir_enc', 'utf-8')

" Use local mouse mappings from vimwiki-local-mappings
let g:vimwiki_use_mouse = get(g:, 'vimwiki_use_mouse', 1)

" 不要将驼峰式词组作为 Wiki 词条
let g:vimwiki_camel_case = get(g:, 'vimwiki_camel_case', 0)

" 声明可以在wiki里面使用的HTML标签
let g:vimwiki_valid_html_tags = get(g:, 'vimwiki_valid_html_tags', 'b,i,s,u,sub,sup,kbd,br,hr,div,del,code,red,center,left,right,h4,h5,h6,pre')

" 将目录条放到plugin目录下
let g:vimwiki_menu = get(g:, 'vimwiki_menu', 'Plugin.Vimwiki')

" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = get(g:, 'vimwiki_hl_cb_checked', 1)

" Use a special method to calculate the correct length of the strings with double-wide characters (to align table cells properly).
" 用于中文字符
" 对于版本大于7.3的版本，选项没什么用
let g:vimwiki_CJK_length = get(g:, 'vimwiki_CJK_length', 1)










au BufRead,BufNewFile *.wiki set filetype=vimwiki
" :autocmd FileType vimwiki map d :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()






" let g:vim_json_syntax_conceal = get(g:, 'vim_json_syntax_conceal', 0)
"
"
" function s:SID()
"   return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
" endfun
"
"
"
"
"
" let s:LEADERMENU = YXVim#lib#import('leadermenu')
"
" let s:menu = s:LEADERMENU.create_menu()
" call s:LEADERMENU.set_command(s:menu, 'Format', 'f', 'call <SNR>' . s:SID() . '_json_format()')
"
" call YXVim#api#optmenu#regist('json', s:menu)
"
"
" "au BufRead,BufNewFile *.json set filetype=json
" "au! Syntax json source /Users/brad/.vim/ftplugin/json.vim
"
"
