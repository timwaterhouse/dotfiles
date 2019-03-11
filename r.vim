
nnoremap <buffer> <localleader>as :call <SID>AddSpaces()<cr>
function! s:AddSpaces()
  let l:infix = [
        \ '<-', '==', '||', '&&',
        \ '+', '\*', '/',
        \ '%>%']
  for x in l:infix
    silent! execute '%s/\(\S\)' . x . '/\1 ' . x . '/g'
    silent! execute '%s/' . x . '\(\S\)/' . x . ' \1/g'
  endfor
  silent! execute '%s/\([^< ]\)-/\1 -/g'
  silent! execute '%s/-\([^> ]\)/- \1/g'
  silent! execute '%s/\([^= ]\)=/\1 =/g'
  silent! execute '%s/=\([^= ]\)/= \1/g'
  silent! execute '%s/,\([^" ]\)/, \1/g'
endfunction

