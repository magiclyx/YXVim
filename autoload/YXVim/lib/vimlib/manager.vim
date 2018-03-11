"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! YXVim#lib#vimlib#manager#get() abort
  return map({
        \ 'update' : '',
        \ 'install' : '',
        \ 'reinstall' : '',
        \ },
        \ "function('s:' . v:key)"
        \ )
endfunction


" Load SpaceVim api
let s:VIM_CO = YXVim#lib#import('compatible')
let s:JOB = YXVim#lib#import('job')
let s:LIST = YXVim#lib#import('list')
let s:LOGGER = YXVim#lib#import('logger')
let s:upgrdwin = YXVim#lib#internal('plugins#updatewindow')


let s:current_state = 'idle'

" init values
let s:plugins = []
let s:pulling_repos = {}
let s:building_repos = {}
" key : plugin name, value : buf line number in manager buffer.
let s:ui_buf = {}

let s:start_time = 0
let s:end_time = 0

let s:total = 0
let s:done = 0

" install plugin manager

let s:max_task_processes = get(g:, 'g:Plugin_Job_Maxprocesses', 8)



function! s:update(...) abort

  let plugins = a:0 == 0 ? sort(keys(dein#get())) : sort(copy(a:1))

  if s:current_state !=# 'idle'  &&  s:current_state !=# 'update'
    call s:LOGGER.warn(' [ plug manager ] plugin manager process is not finished.', 1)
    return
  elseif s:current_state ==# 'update'
    call s:LOGGER.warn(' [SpaceVim] [plugin manager] plugin updating is not finished.', 1)
    call s:upgrdwin.show_window('update', len(plugins))
    return
  else
    call s:upgrdwin.show_window('update', len(plugins))
  endif

  if a:0 == 0
    call insert(plugins, 'YXVim')
  endif

  let s:current_state = 'update'
  let s:plugins = plugins

  let s:total = len(s:plugins)
  let s:done = 0

  let s:start_time = reltime()
  let s:end_time = 0

  if !s:JOB.vim_job && !s:JOB.nvim_job
    let old_funcdepth = &maxfuncdepth
    let &maxfuncdepth = 2000

    call s:run_pull_task(1)

    let &maxfuncdepth = old_funcdepth
  else
    call s:run_pull_task(s:max_task_processes)
  endif

endfunction


function! s:install(...) abort

  let plugins = a:0 == 0 ? sort(map(s:get_uninstalled_plugins(), 'v:val.name')) : sort(copy(a:1))

  if empty(plugins)
    call s:LOGGER.warn(' [ plug manager ] All of the plugins are already installed.', 1)
    return
  endif

  if s:current_state !=# 'idle'  &&  s:current_state !=# 'install'
    call s:LOGGER.warn(' [ plug manager ] plugin manager process is not finished.', 1)
    return
  elseif s:current_state ==# 'install'
    call s:LOGGER.warn(' [SpaceVim] [plugin manager] plugin installing is not finished.', 1)
    call s:upgrdwin.show_window('install', len(s:plugins))
    return
  else
    call s:upgrdwin.show_window('install', len(s:plugins))
  endif


  let s:current_state = 'install'
  let s:plugins = plugins

  let s:total = len(s:plugins)
  let s:done = 0

  let s:start_time = reltime()
  let s:end_time = 0

  if !s:JOB.vim_job && !s:JOB.nvim_job
    let old_funcdepth = &maxfuncdepth
    let &maxfuncdepth = 2000

    call s:run_clone_task(1)

    let &maxfuncdepth = old_funcdepth
  else
    call s:run_clone_task(s:max_task_processes)
  endif

endfunction


function! s:reinstall(...)
  call dein#reinstall(a:1)
endfunction



function! s:run_pull_task(times)

  let trigger_time = 0

  while trigger_time < a:times
    if empty(s:plugins)
      if s:total == s:done
        let s:end_time = reltime()
        call s:upgrdwin.task_finish(reltime(s:start_time, s:end_time))
        let s:current_state = 'idle'
        call s:recache_rtp()
      endif

      break
    endif

    let reponame = s:LIST.shift(s:plugins)
    if reponame ==# 'YXVim'
      let repo = {
            \'name' : 'YXVim',
            \'path' : g:Src_Main_Home
            \}
    else
      let repo = dein#get(reponame)
    endif
    if empty(repo)
      continue
    endif

    call s:pull(repo)
    let trigger_time += 1
  endwhile

endfunction


function! s:run_clone_task(times)

  let trigger_time = 0

  while trigger_time < a:times
    if empty(s:plugins)
      if s:total == s:done
        let s:end_time = reltime()
        call s:upgrdwin.task_finish(reltime(s:start_time, s:end_time))
        let s:current_state = 'idle'
        call s:recache_rtp()
      endif

      break
    endif

    let reponame = s:LIST.shift(s:plugins)
    let repo = dein#get(reponame)
    if empty(repo)
      continue
    endif

    call s:clone(repo)
    let trigger_time += 1
  endwhile

endfunction



function! s:pull(repo) abort

  let argv = ['git', 'pull', '--progress']

  echom string(argv)
  echom string(a:repo.path)

  if s:JOB.vim_job || s:JOB.nvim_job
    let jobid = s:JOB.start(argv,{
          \ 'on_stderr' : function('s:on_install_stdout'),
          \ 'cwd' : a:repo.path,
          \ 'on_exit' : function('s:on_pull_exit')
          \ })

    let s:pulling_repos[jobid] = a:repo
    call s:upgrdwin.download_start(a:repo.name)
  else
    let s:pulling_repos['#'] = a:repo
    call s:upgrdwin.download_start(a:repo.name)
    call s:JOB.start(argv,{
          \ 'on_exit' : function('s:on_pull_exit')
          \ })
  endif

endfunction


function! s:clone(repo) abort

  let url = 'https://github.com/' . a:repo.repo
  let argv = ['git', 'clone', '--recursive', '--progress', url, a:repo.path]

  if s:JOB.vim_job || s:JOB.nvim_job
    let jobid = s:JOB.start(argv,{
          \ 'on_stderr' : function('s:on_install_stdout'),
          \ 'on_exit' : function('s:on_install_exit')
          \ })

    let s:pulling_repos[jobid] = a:repo
    call s:upgrdwin.download_start(a:repo.name)
  else
    let s:pulling_repos['#'] = a:repo
    call s:upgrdwin.download_start(a:repo.name)

    call s:JOB.start(argv,{
          \ 'on_stderr' : function('s:on_install_stdout'),
          \ 'on_exit' : function('s:on_install_exit')
          \ })

  endif
endfunction



function! s:build(repo) abort
  let argv = type(a:repo.build) != 4 ? a:repo.build : s:get_build_argv(a:repo.build)

  if s:JOB.vim_job || s:JOB.nvim_job
    let jobid = s:JOB.start(argv,{
          \ 'on_exit' : function('s:on_build_exit'),
          \ 'cwd' : a:repo.path,
          \ })
    let s:building_repos[jobid] = a:repo
    call s:upgrdwin.build_start(a:repo.name)
  else
    let s:building_repos['#'] = a:repo
    call s:upgrdwin.build_start(a:repo.name)
    call s:JOB.start(argv,{
          \ 'on_exit' : function('s:on_build_exit'),
          \ 'cwd' : a:repo.path,
          \ })
  endif
endfunction



function! s:recache_rtp() abort
  if empty(s:pulling_repos) && empty(s:building_repos)
    " TODO add elapsed time info.
    call dein#recache_runtimepath()
  endif
endfunction


function! s:lock_revision(repo) abort
  let cmd = ['git', '--git-dir', a:repo.path . '/.git', 'checkout', a:repo.rev]
  call s:VIM_CO.system(cmd)
endfunction

" here if a:data == 0, git pull succeed
function! s:on_pull_exit(id, data, event) abort

  let repo = s:pulling_repos[a:id]
  call remove(s:pulling_repos, string(a:id))

  if !empty(get(repo, 'build', '')) && a:data == 0
    call s:build(repo)
  else
    if a:data == 0
      call s:upgrdwin.download_done(repo.name)
    else
      call s:upgrdwin.download_failed(repo.name, 'E(' . a:data .')')
    endif

    let s:done += 1
    call s:run_pull_task(1)
  endif

endfunction


function! s:on_build_exit(id, data, event) abort
  let repo = s:building_repos[a:id]
  call remove(s:building_repos, string(id))

  if a:data == 0
    call s:upgrdwin.build_done(repo.name)
  else
    call s:upgrdwin.build_failed(repo.name)
  endif

  let s:done += 1
  call s:run_pull_task(1)
endfunction



function! s:on_install_stdout(id, data, event) abort
  for str in a:data
    let status = matchstr(str,'\d\+%\s(\d\+/\d\+)')
    if !empty(status)
      call s:upgrdwin.download_process(s:pulling_repos[a:id].name, status)
    endif
  endfor
endfunction


function! s:on_install_exit(id, data, event) abort

  let repo = s:pulling_repos[a:id]
  call remove(s:pulling_repos, string(a:id))

  if get(repo, 'rev', '') !=# ''
    call s:lock_revision(repo)
  endif

  if !empty(get(repo, 'build', '')) && a:data == 0
    call s:build(repo)
  else
    if a:data == 0
      call s:upgrdwin.download_done(repo.name)
    else
      call s:upgrdwin.download_failed(repo.name, 'E(' . a:data .')')
    endif
  endif

  let s:done += 1
  call s:run_clone_task(1)

endfunction




function! s:get_uninstalled_plugins() abort
  return filter(values(dein#get()), '!isdirectory(v:val.path)')
endfunction




function! s:get_build_argv(build) abort
  " TODO check os
  return a:build
endfunction


function! s:open_plugin_dir() abort
  let line = line('.') - 3
  let plugin = filter(copy(s:ui_buf), 's:ui_buf[v:key] == line')
  if !empty(plugin)
    exe 'topleft split'
    enew
    exe 'resize ' . &lines * 30 / 100
    let shell = empty($SHELL) ? YXVim#lib#vimlib#import('system').isWindows ? 'cmd.exe' : 'bash' : $SHELL
    if has('nvim')
      call termopen(shell, {'cwd' : dein#get(keys(plugin)[0]).path})
    else
      call term_start(shell, {'curwin' : 1, 'term_finish' : 'close', 'cwd' : dein#get(keys(plugin)[0]).path})
    endif
  endif
endfunction




