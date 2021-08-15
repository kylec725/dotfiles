" c
lua require'lspconfig'.ccls.setup{}

" go
lua require'lspconfig'.gopls.setup{}

" python
" lua require'lspconfig'.jedi_language_server.setup{}
lua require'lspconfig'.pyright.setup{}

" vim
lua require'lspconfig'.vimls.setup{}

" bash
lua require'lspconfig'.bashls.setup{}
