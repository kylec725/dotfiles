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
    signs = false,
    update_in_insert = false,
    }
)
EOF

" signature support
lua << EOF
require "lsp_signature".setup({
    bind = true,
    handler_opts = {
        border = "rounded",
        }
})
EOF
lua require "lsp_signature".on_attach()
nnoremap <silent> gs :lua vim.lsp.buf.signature_help()<CR>

" lspkind (icons)
lua << EOF
require('lspkind').init({
-- enables text annotations
--
-- default: true
with_text = true,

-- default symbol map
-- can be either 'default' or
-- 'codicons' for codicon preset (requires vscode-codicons font installed)
--
-- default: 'default'
preset = 'codicons',

-- override preset symbols
--
-- default: {}
symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
    },
})
EOF
