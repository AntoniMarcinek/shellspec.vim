" Indentation function for shellspec
function! GetShellSpecIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let line = getline(lnum)

  if exists("*GetShIndent")
    " Handle shell script indentation within spec files
    let ind = GetShIndent()
  else
    let ind = indent(lnum)
  endif


  " Handle shellspec-specific indentation
  if line =~# '^\s*\(Describe\|ExampleGroup\|Context\|Mock\|It\)\>'
    let ind += &shiftwidth
  endif

  " Decrease indent for End
  if getline(v:lnum) =~# '^\s*End\>'
    let ind -= &shiftwidth
  endif


  " Fallback for handling shell script indentation within spec files
  if !exists("*GetShIndent")
    if line =~# '{\s*$'
      let ind += &shiftwidth
    endif

    if getline(v:lnum) =~# '^\s*}\s*$'
      let ind -= &shiftwidth
    endif
  endif


  return ind
endfunction

" Set the indentexpr for shellspec filetype
setlocal indentexpr=GetShellSpecIndent()
setlocal indentkeys+=0=End
