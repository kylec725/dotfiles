" coc

" use <c-j> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <c-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<c-n>" :
      \ coc#refresh()
" assign <c-j> and <c-k> to cycle through suggestions
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"

" map <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" let esc cancel completion
inoremap <expr> <c-c> pumvisible() ? "\<C-e>" : "\<c-c>"
