"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Author: Yuxi Liu
" Version: 2.0 - 01/19/2018

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Timeout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 'timeout'    'ttimeout'		 action
"   off		      off		     do not time out
"   on		      on or off	     time out on :mappings and key codes
"   off		      on		     time out on key codes (overright the key codes value in timeout)

"		ttimeoutlen	映射延迟	   键码延迟	~
"		   < 0		'timeoutlen'	   'timeoutlen'
"		  >= 0		'timeoutlen'	   'ttimeoutlen'


"for mapping and key codes
set ttimeout
set ttimeoutlen=50

" for key codes is different from mapping
set timeout
set timeoutlen=500















