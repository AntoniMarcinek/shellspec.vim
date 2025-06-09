" Indentation function for shellspec
function! GetShellSpecIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let line = getline(lnum)
  let curline = getline(v:lnum)
  let ind = indent(lnum)


  """ First handle shellspec-specific indentation

  let exampleGroup = '\<[fx]\?\(ExampleGroup\|Describe\|Context\)\>'
  let example = '\<[fx]\?\(Example\|It\|Specify\)\>'
  let helper = '^\s*\(Mock\s\+.*\|Data\(:raw\|:expand\)\?\(\s\+|.*\)\?\|Parameters\(:block\|:matrix\|:dynamic\)\?\)\s*$'
  let hookOpen = '\<\(Before\|BeforeEach\|After\|AfterEach\|BeforeAll\|AfterAll\|BeforeCall\|AfterCall\|BeforeRun\|AfterRun\)\s*[''"]\s*{[^}]*$'

  let end = '^\s*End\>'
  let hookClose = '^\s*}\s*[''"]'

  let lineAdds = line =~# '\('..exampleGroup..'\|'..example..'\|'..helper..'\|'..hookOpen..'\)'
  let curlineDecreases = curline =~# '\('..end..'\|'..hookClose..'\)'

  if lineAdds
    let ind += &shiftwidth
  endif

  if curlineDecreases
    let ind -= &shiftwidth
  endif

  if lineAdds || curlineDecreases
    return ind
  endif



  """ Next handle sh indentation
  if exists("*GetShIndent")
    return GetShIndent()
  else
    if line =~# '{\s*$'
      let ind += &shiftwidth
    endif

    if curline =~# '^\s*}\s*$'
      let ind -= &shiftwidth
    endif

    return ind
  endif

endfunction

" Set the indentexpr for shellspec filetype
setlocal indentexpr=GetShellSpecIndent()
setlocal indentkeys+=0=End
