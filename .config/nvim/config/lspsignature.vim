lua << EOF
require "lsp_signature".setup({
bind = true,
doc_lines = 0,
fix_pos = true,
floating_window_above_cur_line = true,
handler_opts = {
    border = "rounded",
    }
})
EOF

nnoremap <silent> gs :lua vim.lsp.buf.signature_help()<CR>
