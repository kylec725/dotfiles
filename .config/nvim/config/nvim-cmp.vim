" set completeopt=menuone,noselect
"
" lua << EOF
" -- Setup nvim-cmp.
" local cmp = require'cmp'
"
" cmp.setup({
" mapping = {
"     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
"     ['<Tab>'] = cmp.mapping.select_next_item(),
"     ['<C-Space>'] = cmp.mapping.complete(),
"     ['<C-e>'] = cmp.mapping.close(),
"     -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
"     -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
"     -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
"     },
" sources = {
"     { name = 'nvim_lsp' },
"     { name = 'buffer' },
"     { name = 'path' },
"
"     -- For luasnip user.
"     -- { name = 'luasnip' },
"
"     -- For ultisnips user.
"     -- { name = 'ultisnips' },
"
"     },
" documentation = {
"     border = { '╭', '─' ,'╮', '│', '╯', '─', '╰', '│' }, -- the border option is the same as `|help nvim_open_win|`
"     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
"     max_width = 120,
"     min_width = 60,
"     max_height = math.floor(vim.o.lines * 0.3),
"     min_height = 1,
"     },
" completion = {
"     completeopt = 'menu,noinsert',
"     preselect = false
"     }
" })
" EOF
" highlight CmpItemAbbr ctermbg=0 ctermfg=7 guibg=#192330 guifg=gray
" highlight PmenuSel ctermbg=7 ctermfg=0 guibg=gray guifg=0
" highlight PmenuSbar ctermbg=grey guibg=grey
" highlight PmenuThumb ctermbg=white guibg=white
