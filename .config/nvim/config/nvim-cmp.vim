" set completeopt=menuone,noselect
"
" " Setup global configuration. More on configuration below.
" lua <<EOF
" local cmp = require('cmp')
" cmp.setup {
"     snippet = {
"         expand = function(args)
"         -- You must install `vim-vsnip` if you use the following as-is.
"         vim.fn['vsnip#anonymous'](args.body)
"     end
"     },
"
" -- You must set mapping if you want.
" mapping = {
"     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
"     ['<Tab>'] = cmp.mapping.select_next_item(),
"     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
"     ['<C-u>'] = cmp.mapping.scroll_docs(4),
"     -- ['<C-Space>'] = cmp.mapping.complete(),
"     -- ['<C-e>'] = cmp.mapping.close(),
"     -- ['<CR>'] = cmp.mapping.confirm({
"     -- behavior = cmp.ConfirmBehavior.Insert,
"     -- select = true,
"     -- })
" },
"
"     -- You should specify your *installed* sources.
"     sources = {
"         { name = 'buffer' },
"         { name = 'nvim_lsp' },
"         },
"     }
" EOF
"
" " Setup buffer configuration (nvim-lua source only enables in Lua filetype).
" " autocmd FileType lua lua require'cmp'.setup.buffer {
" "             \   sources = {
" "                 \     { name = 'buffer' },
" "                 \     { name = 'nvim_lua' },
" "                 \   },
" "                 \ }
