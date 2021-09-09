nnoremap <silent> <leader>db :DlvToggleBreakpoint<CR>
nnoremap <silent> <leader>dm :DlvDebug<CR>
nnoremap <silent> <leader>dt :DlvTest<CR>
nnoremap <silent> <leader>dc :DlvClearAll<CR>

highlight DlvBreakpoint ctermbg=NONE ctermfg=lightgreen guibg=NONE guifg=#81b29a
" highlight DlvTracepoint ctermbg=NONE ctermfg=lightgreen
let g:delve_breakpoint_sign_highlight="DlvBreakpoint"
" let g:delve_tracepoint_sign_highlight="DlvTracepoint"
" let g:delve_breakpoint_sign="▌"
let g:delve_breakpoint_sign="●"
let g:delve_sign_priority=50
