if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "leadermenu"

syn region LeaderMenuKeys start="\["hs=e+1 end="\]\s"he=s-1
            \ contained
syn match LeaderMenuBrackets /\[[^ ]\+\]/
            \ contains=LeaderMenuKeys keepend
syn match LeaderMenuGroupName / +[^\[^\]]\+/ contained
syn region LeaderMenuDesc start="^" end="$"
            \ contains=LeaderMenuBrackets,LeaderMenuGroupName

hi def link LeaderMenuDesc Identifier
hi def link LeaderMenuKeys Type
hi def link LeaderMenuBrackets Delimiter
hi def link LeaderMenuGroupName SpaceVimLeaderMenurGroupName


