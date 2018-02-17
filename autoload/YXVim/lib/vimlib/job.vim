"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 02/17/2018 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! YXVim#lib#vimlib#job#get() abort
  return s:self
endfunction 

" make vim and neovim use same job func.
let s:self = {}
let s:self.jobs = {}
let s:self.nvim_job = has('nvim')
let s:self.vim_job = !has('nvim') && has('job') && has('patch-8.0.0027')
let s:self.vim_co = YXVim#lib#import('compatible')
let s:self._message = []

let s:id_sequence = 0

if !s:self.vim_job
  augroup SpaceVim_job
    au!
    au! User SpaceVim_job_stdout nested call call(s:self.opts.on_stdout, s:self.job_argv)
    au! User SpaceVim_job_stderr nested call call(s:self.opts.on_stderr, s:self.job_argv)
    au! User SpaceVim_job_exit nested call call(s:self.opts.on_exit, s:self.job_argv)
  augroup ENd
endif

function! s:self.warn(...) abort
  if len(a:000) == 0
    echohl WarningMsg | echom 'Current version do not support job feature, fallback to sync system()' | echohl None
  elseif len(a:000) == 1 && type(a:1) == type('')
    echohl WarningMsg | echom a:1| echohl None
  else
  endif
endfunction

function! s:self.warp(argv, opts) abort
  let obj = {}
  let obj._argv = a:argv
  let obj._opts = a:opts
  let obj.in_io = get(a:opts, 'in_io', 'pipe')

  " @vimlint(EVL103, 1, a:job_id)
  function! obj._out_cb(job_id, data) abort
    if has_key(self._opts, 'on_stdout')
      call self._opts.on_stdout(self._opts.jobpid, [a:data], 'stdout')
    endif
  endfunction

  function! obj._err_cb(job_id, data) abort
    if has_key(self._opts, 'on_stderr')
      call self._opts.on_stderr(self._opts.jobpid, [a:data], 'stderr')
    endif
  endfunction

  function! obj._exit_cb(job_id, data) abort
    if has_key(self._opts, 'on_exit')
      call self._opts.on_exit(self._opts.jobpid, a:data, 'exit')
    endif
  endfunction
  " @vimlint(EVL103, 0, a:job_id)

  let obj = {
          \ 'argv': a:argv,
          \ 'opts': {
            \ 'mode': 'nl',
            \ 'in_io' : obj.in_io,
            \ 'out_cb': obj._out_cb,
            \ 'err_cb': obj._err_cb,
            \ 'exit_cb': obj._exit_cb,
          \ }
        \ }

  if has_key(a:opts, 'cwd')
    call extend(obj.opts, {'cwd' : a:opts.cwd})
  endif

  return obj

endfunction

" start a job, and return the job_id.
function! s:self.start(argv, ...) abort

  let opts = {}
  if a:0 > 0
    let opts = a:1
  endif

  let id = s:id_sequence
  let s:id_sequence += 1
  if s:id_sequence >= 2147483390
    s:id_sequence = 0
  endif


  if self.vim_job

    let opts.jobpid = id
    let wrapped = self.warp(a:argv, opts)

    " handle cwd
    if has_key(wrapped.opts, 'cwd') && !has('patch-8.0.0902')
      let old_wd = getcwd()
      let cwd = expand(wrapped.opts.cwd, 1)
      " Avoid error E475: Invalid argument: cwd
      call remove(wrapped.opts, 'cwd')
      exe 'cd' fnameescape(cwd)
    endif

    let job = job_start(wrapped.argv, wrapped.opts)

    "handle cwd
    if exists('old_wd')
      exe 'cd' fnameescape(old_wd)
    endif

    call extend(self.jobs, {id : job})

    return id
  else

    " handle cwd
    if has_key(opts, 'cwd')
      let old_wd = getcwd()
      let cwd = expand(opts.cwd, 1)
      exe 'cd' fnameescape(cwd)
    endif

    let output = self.vim_co.systemlist(a:argv)

    " handle cwd
    if exists('old_wd')
      exe 'cd' fnameescape(old_wd)
    endif


    call extend(self.jobs, {id : id})


    let s:self.opts = opts
    if v:shell_error

      " handle stderr
      if has_key(opts,'on_stderr')
        let s:self.job_argv = [id, output, 'stderr']
        try
          doautocmd User SpaceVim_job_stderr
        catch
          doautocmd User SpaceVim_job_stderr
        endtry
      endif
    else

      " handle stdout
      if has_key(opts,'on_stdout')
        let s:self.job_argv = [id, output, 'stdout']
        try
          doautocmd User SpaceVim_job_stdout
        catch
          doautocmd User SpaceVim_job_stdout
        endtry
      endif
    endif

    " handle exit
    if has_key(opts,'on_exit')
      let s:self.job_argv = [id, v:shell_error, 'exit']
      try
        doautocmd User SpaceVim_job_exit
      catch 
        doautocmd User SpaceVim_job_exit
      endtry
    endif

    return id
  endif
endfunction

function! s:self.stop(id) abort
  if self.vim_job
    if has_key(self.jobs, a:id)
      call job_stop(get(self.jobs, a:id))
      call remove(self.jobs, a:id)
    endif
  else
    call self.warn()
  endif
endfunction

function! s:self.send(id, data) abort
  if self.vim_job
    if has_key(self.jobs, a:id)
      let job = get(self.jobs, a:id)
      let chanel = job_getchannel(job)
      if type(a:data) == type('')
        call ch_sendraw(chanel, a:data . "\n")
      else
        call ch_sendraw(chanel, join(a:data, "\n"))
      endif
    else
      call self.warn('No job with such id')
    endif
  else
    call self.warn()
  endif
endfunction

function! s:self.status(id) abort
  if self.vim_job
    if has_key(self.jobs, a:id)
      return job_status(get(self.jobs, a:id))
    endif
  else
    call self.warn('No job with such id!')
  endif
endfunction

function! s:self.list() abort
  return copy(self.jobs)
endfunction

function! s:self.info(id) abort
  let info = {}
  if self.vim_job
    if has_key(self.jobs, a:id)
      return job_info(get(self.jobs, a:id))
    else
      call self.warn('No job with such id!')
    endif
  else
    call self.warn()
  endif
endfunction

function! s:self.debug() abort
  echo join(self._message, "\n")
endfunction



