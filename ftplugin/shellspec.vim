setlocal syntax=shellspec.sh

function! s:SaveFoldStates()
    let b:saved_folds = []
    let l = 1
    while l <= line('$')
        call add(b:saved_folds, foldclosed(l))
        let l += 1
    endwhile
endfunction

function! s:RestoreFoldStates()
    let l = 1
    for fold in b:saved_folds
        if fold > 0 && l <= fold
            execute l . "," . fold . "foldclose"
        elseif fold == 0
            execute l . "foldopen!"
        endif
        let l += 1
    endfor
endfunction
function! s:FormatParagraphs() abort
    call s:SaveFoldStates()
    let l:save = winsaveview()
    norm gg=G
    call winrestview(l:save)
    call s:RestoreFoldStates()
endfunction
au BufWritePre *_spec.sh call s:FormatParagraphs()


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
