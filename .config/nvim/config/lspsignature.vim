lua << EOF
-- require "lsp_signature".setup({
-- bind = true,
-- handler_opts = {
--     border = "rounded",
--     doc_lines = 0,
--     floating_window_above_cur_line = true,
--     }
-- })
EOF

" nnoremap <silent> gs :lua vim.lsp.buf.signature_help()<CR>
