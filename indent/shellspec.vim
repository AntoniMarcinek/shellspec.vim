" Indentation function for shellspec
function! GetShellSpecIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)
  let line = getline(lnum)

  if line =~# '^\s*\(Describe\|Context\|Mock\|It\)\>'
    let ind += &shiftwidth
  endif

  " Decrease indent for End
  if getline(v:lnum) =~# '^\s*End\>'
    let ind -= &shiftwidth
  endif

  " Handle shell script indentation within spec files
  if line =~# '{\s*$'
    let ind += &shiftwidth
  endif

  if getline(v:lnum) =~# '^\s*}\s*$'
    let ind -= &shiftwidth
  endif


  return ind
endfunction

" Set the indentexpr for shellspec filetype
setlocal indentexpr=GetShellSpecIndent()
