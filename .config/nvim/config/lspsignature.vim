lua << EOF
require "lsp_signature".setup({
bind = true,
handler_opts = {
    border = "rounded",
    }
})
EOF

nnoremap <silent> gs :lua vim.lsp.buf.signature_help()<CR>
