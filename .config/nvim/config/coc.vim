" coc

" use <c-j> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<c-n>" :
      \ coc#refresh()
" assign <c-j> and <c-k> to cycle through suggestions
inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"

" let esc cancel completion
inoremap <expr> <s-bs> pumvisible() ? "\<C-e>" : "\<s-bs>"
