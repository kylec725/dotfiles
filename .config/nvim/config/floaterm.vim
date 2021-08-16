nnoremap <silent> <leader>t :FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>
autocmd BufWinEnter,WinEnter term://* startinsert

let g:floaterm_width = 0.7
let g:floaterm_height = 0.8
let g:floaterm_position = 'center'
let g:floaterm_title = ''
let g:floaterm_borderchars = "─│─│╭╮╯╰"

highlight FloatermBorder ctermbg=NONE guibg=NONE
