set completeopt=menuone,noselect

lua << EOF
require'compe'.setup {
enabled = true;
autocomplete = true;
debug = false;
min_length = 1;
preselect = 'disable';
throttle_time = 50;
source_timeout = 200;
resolve_timeout = 800;
incomplete_delay = 400;
max_abbr_width = 100;
max_kind_width = 100;
max_menu_width = 100;
documentation = {
    border = { '╭', '─' ,'╮', '│', '╯', '─', '╰', '│' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
    };

source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
    };
}
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Esc behavior in the PUM
" inoremap <silent><expr> <Esc> pumvisible() ? "\<Esc>" : "\<Esc>"

" for delimitMate
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
