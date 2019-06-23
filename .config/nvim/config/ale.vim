" ale

nnoremap <LEADER>ad :ALEDetail<CR>
nmap <leader>aj <Plug>(ale_next_wrap)
nmap <leader>ak <Plug>(ale_previous_wrap)
" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
