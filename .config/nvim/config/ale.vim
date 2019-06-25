" ale

nnoremap <LEADER>ad :ALEDetail<CR>
nmap <leader>aj <Plug>(ale_next_wrap)
nmap <leader>ak <Plug>(ale_previous_wrap)

" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" customize symbols
let g:ale_sign_error = "●"
let g:ale_sign_warning = "●"

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" highlighting
hi ALEWarning ctermbg=yellow
hi ALEError ctermbg=red
