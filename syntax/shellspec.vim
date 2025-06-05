" Use shell syntax mixed with shellspec one, both on top level and contained
runtime! syntax/sh.vim
unlet b:current_syntax
syntax include @Shell syntax/sh.vim

" Objects that can be used (almost) in every place in the spec file
syntax cluster shellSpecEverywhere contains=@Shell,@shellSpecHelpers,shellSpecHooksRegion,shellSpecDirectives

""" Examples grouping {{{1
syntax region shellSpecExampleGroupRegion matchgroup=shellSpecExampleGroup start="\<[fx]\?\(ExampleGroup\|Describe\|Context\)\>" end="End" fold contains=@shellSpecEverywhere,shellSpecExampleGroupRegion,shellSpecExampleRegion
syntax region shellSpecExampleRegion matchgroup=shellSpecExample start="\<[fx]\?\(Example\|It\|Specify\)\>" end="End" fold contains=@shellSpecEverywhere,shellSpecEvaluationStart,shellSpecExpectationStart


""" Helpers {{{1
syntax cluster shellSpecHelpers contains=shellSpecHelpersComplexRegion,shellSpecHelpersSimple
syntax region shellSpecHelpersComplexRegion matchgroup=shellSpecHelpersComplex start="^\s*\(Mock\s\+.*\|Data\(:raw\|:expand\)\?\(\s\+|.*\)\?\|Parameters\(:block\|:matrix\|:dynamic\)\?\)\s*$" end="End" fold contains=@shellSpecEverywhere
syntax match shellSpecHelpersSimple "\(Skip\(\s\+if\)\?\|Pending\|Todo\|Data\|Parameters:value\|Include\|Path\|File\|Dir\|Intercept\|Set\|Dump\)"


""" Evaluation {{{1
syntax keyword shellSpecEvaluationStart When nextgroup=shellSpecEvaluation2 skipwhite contained
syntax keyword shellSpecEvaluation2 call run nextgroup=shellSpecEvaluation3 skipwhite contained
syntax keyword shellSpecEvaluation3 command script source contained


""" Expectation {{{1
syntax cluster shellSpecAllModifiersAndSubjects contains=shellSpecModifiersOrdinals,shellSpecModifiersShorthand,shellSpecModifiers,@shellSpecSubjects
syntax cluster shellSpecSubjects contains=shellSpecSimpleSubjects,shellSpecComplexSubjects
syntax cluster shellSpecMatchers contains=shellSpecSimpleMatchers,shellSpecBeMatchers,shellSpecHasMathers

syntax keyword shellSpecExpectationStart The Assert nextgroup=@shellSpecAllModifiersAndSubjects skipwhite contained

syntax keyword shellSpecModifiersOrdinals zeroth first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth thirteenth fourteenth fifteenth sixteenth seventeenth eighteenth nineteenth twentieth nextgroup=shellSpecModifiersShorthand,shellSpecModifiers skipwhite contained

" Shorthand -> both as modifiers and subjects
syntax keyword shellSpecModifiersShorthand line word nextgroup=shellSpecModifiersShorthandFiller skipwhite contained
syntax match shellSpecModifiersShorthandFiller "\zs.\{-}\ze\(of\|should\)" nextgroup=shellSpecModifiersOf,shellSpecExpectationShould skipwhite contained transparent
syntax keyword shellSpecModifiers lines length contents result nextgroup=shellSpecModifiersFiller skipwhite contained
syntax match shellSpecModifiersFiller "\zs.\{-}\zeof" nextgroup=shellSpecModifiersOf skipwhite contained transparent
syntax keyword shellSpecModifiersOf of nextgroup=@shellSpecAllModifiersAndSubjects skipwhite contained

syntax keyword shellSpecSimpleSubjects stdout output stderr error status nextgroup=shellSpecExpectationShould skipwhite contained
syntax keyword shellSpecComplexSubjects path file directory function value variable nextgroup=shellSpecSubjectsFiller skipwhite contained
syntax match shellSpecSubjectsFiller "\zs.*\zeshould" nextgroup=shellSpecExpectationShould skipwhite contained transparent

syntax match shellSpecExpectationShould "should\(\s\+not\)\?\>" nextgroup=@shellSpecMatchers skipwhite contained

syntax match shellSpecSimpleMatchers "\(satisfy\|exist\|equal\|eq\|start\s\+with\|end\s\+with\|include\|match\s\+pattern\)\>" contained
syntax match shellSpecBeMatchers "be\s\+\(exist\|file\|directory\|empty\s\+file\|empty\s\+directory\|symlink\|pipe\|socket\|readable\|writable\|executable\|block_device\|character_device\|success\|failure\|successful\|valid\s\+number\|valid\s\+funcname\|defined\|undefined\|present\|blank\|exported\|readonly\)\>" contained
syntax match shellSpecHasMathers "\(has\|have\)\s\+\(setgid\|setuid\)\>" contained


""" Hooks {{{1
syntax region shellSpecHooksRegion matchgroup=shellSpecHooks start="\(Before\|BeforeEach\|After\|AfterEach\|BeforeAll\|AfterAll\|BeforeCall\|AfterCall\|BeforeRun\|AfterRun\)\s*['"]" end="['"]" fold contains=@Shell

""" Directives {{{1
syntax match shellSpecDirectives "%\(const\|text\|putsn\|=\|-\|puts\|printf\|sleep\|preserve\|logger\|data\)\>" containedin=@Shell


""" Highlighting {{{1
hi def link shellSpecExampleGroup ModeMsg
hi def link shellSpecExample shellSpecExampleGroup

hi def link shellSpecHelpersComplex Special
hi def link shellSpecHelpersSimple shellSpecHelpersComplex

hi def link shellSpecEvaluationStart Function

hi def link shellSpecEvaluation2 Statement
hi def link shellSpecEvaluation3 shellSpecEvaluation2

hi def link shellSpecExpectationStart Question
hi def link shellSpecExpectationShould shellSpecExpectationStart

hi def link shellSpecSimpleSubjects Identifier
hi def link shellSpecComplexSubjects shellSpecSimpleSubjects

hi def link shellSpecModifiers Operator
hi def link shellSpecModifiersOrdinals shellSpecModifiers
hi def link shellSpecModifiersShorthand shellSpecModifiers
hi def link shellSpecModifiersOf shellSpecModifiers

hi def link shellSpecSimpleMatchers Conditional
hi def link shellSpecBeMatchers shellSpecSimpleMatchers
hi def link shellSpecHasMathers shellSpecSimpleMatchers

hi def link shellSpecHooks Label

hi def link shellSpecDirectives Macro

" {{{1 vim: fdm=marker
