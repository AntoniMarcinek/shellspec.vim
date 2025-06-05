setlocal syntax=shellspec.sh

function! ShellspecFolds()
    let thisline = getline(v:lnum)
    if match(thisline, '^\s*\(Describe\|It\|Mock\)') >= 0
        return "a1"
    elseif match(thisline, '^\s*\(End\)') >= 0
        return "s1"
    else
        return "="
    endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=ShellspecFolds()
