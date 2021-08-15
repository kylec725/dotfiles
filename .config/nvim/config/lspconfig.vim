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


" automatic reload
lua << EOF
local function setup_servers()
require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
setup_servers() -- reload installed servers
vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
EOF

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
