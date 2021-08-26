"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')

" Editing or Typing
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag', {'for': 'html'}
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips', {'for': 'tex'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'voldikss/vim-floaterm'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'

" File Navigation
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'gcavallanti/vim-noscrollbar'
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-cool'
" Plug 'wfxr/minimap.vim'
Plug 'Xuyuanp/scrollbar.nvim'
" Plug 'moll/vim-bbye'

" Visual Changes
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'gregsexton/MatchTag', {'for': 'html'}
Plug 'machakann/vim-highlightedyank'
" Plug 'mhinz/vim-janah'
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'
" Plug 'joeytwiddle/sexy_scroller.vim'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'akinsho/nvim-bufferline.lua'

" Language Syntax/Suggestions
Plug 'dense-analysis/ale'
Plug 'nathunsmitty/nvim-ale-diagnostic'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-path'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'onsails/lspkind-nvim'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}  " We recommend updating the parsers on update

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

"----------------------"
" General Vim Settings "
"----------------------"

" colorscheme
lua << EOF
local nightfox = require('nightfox')
local colors = require('nightfox.colors').load()

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
fox = "nightfox", -- Which fox style should be applied
transparent = true, -- Disable setting the background color
terminal_colors = false, -- Configure the colors used when opening :terminal
styles = {
    comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
    functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
    keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
    strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
    variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
    },
colors = {}, -- Override default colors
hlgroups = {
    NormalFloat = "NONE",
    }, -- Override highlight groups
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
EOF
colorscheme nightfox
set background=dark
set termguicolors

" font
set guifont=JetBrainsMono\ Nerd\ Font:h8

" Change clipboard register for vim
set clipboard=unnamedplus

" Important settings
syntax on                   " Enable syntax highlighting
filetype plugin indent on   " Enable filetype-specific plugins, indents, and detection
set hidden

" enable .h files to be set to filetype c
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" Mode switch delay
set timeoutlen=1000 ttimeoutlen=0

" Update time for gitgutter
set updatetime=100

" Preview search and replace
set inccommand=nosplit

" Split windows to right
set splitright

" Line numbers
set number relativenumber
" Current line number color
highlight LineNr ctermfg=12 guifg=gray ctermbg=NONE guibg=NONE
highlight CursorLineNR ctermfg=9 guifg=#dbc074 ctermbg=NONE guibg=NONE

" Always show at least one line above/below the cursor.
set scrolloff=3
" Always show at least one line left/right of the cursor.
set sidescrolloff=5

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable spell check functionality
set spelllang=en

" case insensitive search unless upper case is used
set ignorecase
set smartcase

" terminal cursor
highlight TermCursor ctermfg=NONE guibg=#d7ffff ctermbg=195 gui=NONE cterm=NONE
highlight TermCursorNC ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" Cursor blinking
set guicursor=a:blinkon100
" Cursor as block in insert mode
" set guicursor=

" disable mouse
set mouse=

" set background color to be transparent
highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE

" comment color
highlight Comment ctermfg=102

" search match color
" highlight Search ctermbg=magenta ctermfg=black guibg=magenta guifg=black
" highlight current search match in different color
" highlight IncSearch ctermbg=blue ctermfg=black guibg=blue guifg=black

" matched parentheses color
highlight clear MatchParen
highlight MatchParen ctermbg=NONE ctermfg=magenta guibg=NONE guifg=magenta

" Warning message and Error
highlight WarningMsg ctermbg=NONE ctermfg=yellow
highlight ErrorMsg ctermbg=NONE ctermfg=red

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Visual Wrapping
set nowrap
highlight Visual ctermbg=241

" Clear SignColumn/Gutter color
highlight clear SignColumn

" Change window pane separator to a single line
set fillchars+=vert:│
highlight VertSplit cterm=NONE ctermfg=12 guifg=12 ctermbg=NONE guibg=NONE

" Remove line numbers in terminals (especially for debugging"
autocmd TermOpen * setlocal nonumber norelativenumber

" remove latex concealment
let g:tex_conceal = ""

" remove vimtex vim version warning
let g:vimtex_version_check = 0

" highlight characters after column 80
highlight OverLength ctermbg=darkgray ctermfg=black guibg=darkgray guifg=black
" match OverLength /\%81v.\+/

" darken tildes at EOF
" highlight EndOfBuffer ctermfg=16 guifg=16

" whitespace highlight
highlight ExtraWhitespace ctermbg=white guibg=white
highlight pythonSpaceError ctermbg=white guibg=white

" pop-up menu colors
highlight Pmenu ctermbg=0 ctermfg=7 guibg=0 guifg=gray
highlight PmenuSel ctermbg=7 ctermfg=0 guibg=gray guifg=0
highlight PmenuSbar ctermbg=grey guibg=grey
highlight PmenuThumb ctermbg=white guibg=white

" floating window colors
highlight NormalFloat ctermbg=NONE guibg=NONE
" match FZF guibg to bg+ and info
highlight FZFFloat ctermbg=black guibg=#152238
highlight FloatBorder ctermbg=NONE guibg=NONE ctermfg=white guifg=#dfdfe0

" set tex flavor
let g:tex_flavor = "latex"

" undo history
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undofile
set undodir=/tmp/.vim-undo-dir
set undoreload=10000

" indent settings
set tabstop=8
set expandtab
set softtabstop=-1
" auto indent command
command Indent :normal! MmQgg=G'Qzz
" filetype indent settings
autocmd FileType html setlocal shiftwidth=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType ruby setlocal shiftwidth=2
" autocmd FileType tex setlocal shiftwidth=2 spell | nnoremap <leader>p :cd %:p:h<CR>:!pdflatex %<CR>
autocmd FileType tex setlocal shiftwidth=2 spell | ALEDisable | let delimitMate_quotes = "\" ' ` $"
autocmd FileType markdown setlocal spell shiftwidth=4
autocmd FileType ocaml setlocal shiftwidth=2
autocmd FileType c setlocal shiftwidth=4 cindent
autocmd FileType cpp setlocal shiftwidth=4 cindent cinoptions=g0+N-sw
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType java setlocal shiftwidth=4
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType python setlocal shiftwidth=4
autocmd FileType vim setlocal shiftwidth=4
autocmd FileType sql setlocal shiftwidth=4
autocmd FileType lua setlocal shiftwidth=3
autocmd FileType fish setlocal shiftwidth=4 | ALEDisable
autocmd FileType sh setlocal shiftwidth=8
" add to gray out text after column 80
" | match OverLength /\%81v.\+/

"-------------------------"
" General Vim Keybindings "
"-------------------------"

" map the leader key
let mapleader=';'
" remove leader timeout
set notimeout
set ttimeout
" cancel leader command
nnoremap <leader><leader> jk

" map :up and :q
noremap <silent> <leader>w :up<CR>
noremap <leader>q :q<CR>

" update buffer
noremap <leader>r :edit!<CR>

" map buffer navigation keys
nnoremap <silent> - :bprevious<CR>
nnoremap <silent> = :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>
" nnoremap <silent> <leader>bd :Bdelete<CR>

" remap paste to adjust indentation
nnoremap p p`[v`]=
nnoremap P P`[v`]=
vnoremap p p`[v`]=
vnoremap P P`[v`]=

" remap the jump mark key
noremap ' `

" map shift + hjkl
noremap <S-h> ^
noremap <S-j> L
noremap <S-k> H
noremap <S-L> g_
" autocmd FileType fern nnoremap <buffer> <S-j> 3j | nnoremap <buffer> <S-k> 3k
autocmd FileType vista_kind nnoremap <buffer> <S-j> 3j | nnoremap <buffer> <S-k> 3k

" window navigation keys
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" window resize keys
noremap <silent> <C-Left> :vertical resize -5<CR>
noremap <silent> <C-Down> :resize -5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Right> :vertical resize +5<CR>

" make Y behave like C and D
nnoremap Y y$

" replace the word under cursor
nnoremap <leader>sr :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap <leader>sc :%s/\<<c-r><c-w>\>//gIc<left><left><left><left>
" replace visual selection
vnoremap <leader>sr y:%s/\<<c-r>"\>//gI<left><left><left>
vnoremap <leader>sc y:%s/\<<c-r>"\>//gIc<left><left><left><left>

" auto indent command
nnoremap <leader>i :Indent<CR>

" remove search highlighting
nnoremap <silent> <Esc> :noh<CR>

" insert empty lines
nnoremap <silent><Space> o<Esc>

" escape as terminal escape
" tnoremap <Esc> <C-\><C-n>

" change cwd to the open buffer's location
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" spell check fast correction
nnoremap <leader>sp <Esc>[s1z=``

"-----------------"
" Plugin Settings "
"-----------------"

" Glob and source all the files in `path`
function! SourceAllIn(path)
    for s:fpath in split(globpath('~/.config/nvim' . a:path, '*.vim'), '\n')
        exe 'source' s:fpath
    endfor
endfunction

" Get plugin configs
call SourceAllIn('/config/')

" Yank Highlight
let g:highlightedyank_highlight_duration = 500

" Git Commands and Settings - Fugitive and Gitgutter !!!!!

nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Git commit<CR>
" nnoremap <leader>gr :Git restore %<CR>

" indent line
let g:indentLine_char = '▏'
" let g:indentLine_color_term = 7
" let g:indentLine_conceallevel = 0

" Tabularize binding
nnoremap <leader><Tab> :Tabularize /
vnoremap <leader><Tab> :Tabularize /

" Snippets !!!!!
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-l>"
let g:UltiSnipsJumpBackwardTrigger = "<c-h>"

" DelimitMate !!!!!
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" change vim-surround visual mode mapping
xmap s <Plug>VSurround

" go settings
let g:go_gopls_enabled = 0
let g:go_template_use_pkg = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_operators = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

" minimap
let g:minimap_auto_start = 1
let g:minimap_width = 20

" scrollbar
let g:scrollbar_right_offset = 0
let g:scrollbar_shape = {
            \ 'head': '█',
            \ 'body': '█',
            \ 'tail': '█',
            \ }
augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end

" indent_blankline
let g:indent_blankline_char_highlight_list = ['Comment']

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
},
}
EOF

" sexy scroll
let g:SexyScroller_EasingStyle = 2
