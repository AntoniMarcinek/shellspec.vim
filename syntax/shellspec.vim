if exists("b:current_syntax")
  finish
endif

syntax keyword shellSpecKeyWords contained End Describe It When Mock
hi def link shellSpecKeyWords Function

let b:current_syntax = "shellspec"
