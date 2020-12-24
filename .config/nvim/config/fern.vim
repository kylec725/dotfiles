nnoremap <silent> <leader>n :Fern . -drawer -width=38 -toggle<CR>

let g:fern#disable_default_mappings = 1

autocmd FileType fern nmap <buffer> r <Plug>(fern-action-reload)
autocmd FileType fern nmap <buffer> h <Plug>(fern-action-collapse)
autocmd FileType fern nmap <buffer> l <Plug>(fern-action-open-or-expand)
autocmd FileType fern nmap <buffer> H <Plug>(fern-action-leave)
autocmd FileType fern nmap <buffer> L <Plug>(fern-action-open-or-enter)
autocmd FileType fern nmap <buffer> zh <Plug>(fern-action-hidden:toggle)
autocmd FileType fern nmap <buffer> <CR> <Plug>(fern-action-open-or-enter)
autocmd FileType fern nmap <buffer> N <Plug>(fern-action-new-path)
autocmd FileType fern nmap <buffer> s <Plug>(fern-action-mark:toggle)
autocmd FileType fern nmap <buffer> C <Plug>(fern-action-rename)
