" ale

nnoremap <LEADER>ad :ALEDetail<CR>
nmap <leader>aj <Plug>(ale_next_wrap)
nmap <leader>ak <Plug>(ale_previous_wrap)
nnoremap gd :ALEGoToDefinition<CR>

" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" customize symbols
" let g:ale_sign_error = "●"
" let g:ale_sign_warning = "●"
let g:ale_sign_error = "▌"
let g:ale_sign_warning = "▌"

highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" highlighting
hi ALEWarning ctermbg=yellow ctermfg=0
hi ALEError ctermbg=red ctermfg=7

autocmd Filetype ale-preview nnoremap <buffer> <Esc> :q<CR>

let g:ale_java_javac_classpath = "/home/kyle/school/fall19/420/MeeshQuest-Skeleton-1.zip_expanded/MeeshQuest-Skeleton-1/lib/cmsc420util.jar"
" let g:ale_java_javac_classpath = "/home/kyle/school/fall19/420/MeeshQuest-Skeleton-1.zip_expanded/MeeshQuest-Skeleton-1/"
" set linters
" let g:ale_linters = {'cpp': ['ccls']}

" ignore line too long in python
let g:ale_python_flake8_options = '--ignore=E501'
