if exists("b:current_syntax")
  finish
endif

syntax keyword shellSpecKeyWords contained End
syntax keyword shellSpecKeyWords contained ExampleGroup Describe Context
syntax keyword shellSpecKeyWords contained Example It Specify
syntax keyword shellSpecKeyWords contained Mock
syntax keyword shellSpecKeyWords contained When nextgroup=shellSpecKeyWords2
syntax keyword shellSpecKeyWords2 contained call run nextgroup=shellSpecKeyWords3
syntax keyword shellSpecKeyWords3 contained command script source

syntax keyword shellSpecSubjects contained stdout output line word stderr status path file directory value function variable

syntax keyword shellSpecModifiers contained line lines word length contents result
syntax keyword shellSpecModifiers contained of should equal eq

syntax keyword shellSpecMatchers contained satisfy exist be exist file directory empty empty symlink pipe socket readable writable executable block_device character_device has have setgid setgid setuid setuid

hi def link shellSpecKeyWords Function
hi def link shellSpecKeyWords2 Statement
hi def link shellSpecKeyWords3 Statement
hi def link shellSpecSubjects Identifier
hi def link shellSpecModifiers Operator
hi def link shellSpecMatchers Conditional

let b:current_syntax = "shellspec"
