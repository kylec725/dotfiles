nnoremap <leader>w :cd %:p:h<CR>:w<CR>
nnoremap <leader>p :cd %:p:h<CR>:up<CR>:silent! !pdflatex %<CR>:silent! !zathura %:p:t:r.pdf &<CR>
" nnoremap <leader>p :cd %:p:h<CR>:w temp.tex<CR>:silent! !pdflatex temp.tex<CR>:silent! !zathura temp.pdf &<CR>
" let g:temptex = expand('%:p:t:r') 
" autocmd BufNewFile,BufRead *.tex write temp.tex
" autocmd CursorHold <buffer> silent update! temp.tex
" autocmd FileWritePost *.tex silent! !pdflatex -jobname=%:p:t:r temp.tex
autocmd BufWritePost *.tex !pdflatex %
