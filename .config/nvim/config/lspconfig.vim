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

" ale integration
lua << EOF
require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    }
)
EOF
