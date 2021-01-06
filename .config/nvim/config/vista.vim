" Vista

" nnoremap <silent> <leader>v :Vista!!<CR>
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" See all the avaliable executives via `:echo g:vista#executives`.
" let g:vista_default_executive = 'coc'
" let g:vista#renderer#enable_icon = 1
" let g:vista_stay_on_open = 0
" let g:vista_sidebar_width = 40

"close vista if it's the only buffer left in the window
" autocmd WinEnter * if &ft == 'vista_kind' && winnr('$') == 1 | q | endif
