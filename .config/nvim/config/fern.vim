nnoremap <silent> <leader>n :Fern . -drawer -width=38 -toggle<CR>

let g:fern#disable_default_mappings = 1

autocmd FileType fern nmap <buffer> r <Plug>(fern-action-reload)
autocmd FileType fern nmap <buffer> h <Plug>(fern-action-collapse)
autocmd FileType fern nmap <buffer> l <Plug>(fern-action-open-or-expand)
autocmd FileType fern nmap <buffer> H <Plug>(fern-action-leave)
autocmd FileType fern nmap <buffer> L <Plug>(fern-action-open-or-enter)
autocmd FileType fern nmap <buffer> zh <Plug>(fern-action-hidden:toggle)
autocmd FileType fern nmap <buffer> <CR> <Plug>(fern-action-open-or-enter)

" augroup fern-custom
"     autocmd! *
"     " close fern if it is the last buffer/split open
"     autocmd WinEnter * if &ft == 'fern' && winnr('$') == 1 | q | endif
" augroup END
