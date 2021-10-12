nnoremap <silent> <leader>t :FloatermToggle main<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle main<CR>
" using lazygit in floatterm makes current buffer unhidden if lazygit git adds it
" this makes us unable to close the buffer
" nnoremap <silent> <leader>gg :FloatermNew --name=lazygit --disposable lazygit<CR>
" tnoremap <silent> <leader>gg <C-\><C-n>:FloatermHide lazygit<CR>
nnoremap <silent> <leader>gg :terminal<CR>ilazygit<CR>
tnoremap <silent> <leader>gg <C-\><C-n>:bd!<CR>
autocmd BufWinEnter,WinEnter term://* startinsert

let g:floaterm_width = 0.8
let g:floaterm_height = 0.85
let g:floaterm_position = 'center'
let g:floaterm_title = ''
let g:floaterm_borderchars = "─│─│╭╮╯╰"

highlight FloatermBorder ctermbg=NONE guibg=NONE
