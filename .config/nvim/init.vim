"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')

" Editing or Typing
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-repeat'
Plug 'vimlab/split-term.vim'
Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'
Plug 'voldikss/vim-floaterm'

" File Navigation
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'majutsushi/tagbar'
" Plug 'ryanoasis/vim-devicons'
Plug 'gcavallanti/vim-noscrollbar'
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-cool'
" Plug 'wfxr/minimap.vim'

" Visual Changes
Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'gregsexton/MatchTag'
Plug 'mustache/vim-mustache-handlebars'
Plug 'arcticicestudio/nord-vim'
" Plug 'miyakogi/conoline.vim'
" Plug 'RRethy/vim-illuminate'
Plug 'machakann/vim-highlightedyank'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sinetoami/lightline-hunks'
Plug 'maximbaz/lightline-ale'

" Language Syntax/Suggestions
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'fatih/vim-go'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

"----------------------"
" General Vim Settings "
"----------------------"

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
set updatetime=200

" Preview search and replace
set inccommand=nosplit

" Line numbers
set number relativenumber
" Current line number color
highlight LineNr ctermfg=12
highlight CursorLineNR ctermfg=11

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

" search match color
highlight Search ctermbg=green ctermfg=black
" highlight current search match in different color
highlight IncSearch ctermbg=black ctermfg=magenta

" matched parentheses color
highlight MatchParen ctermbg=magenta ctermfg=black

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Visual Wrapping
set nowrap

" Clear SignColumn/Gutter color
highlight clear SignColumn

" Cursor blinking
set guicursor=a:blinkon100
" Cursor as block in insert mode
set guicursor=

" Change window pane separator to a single line
set fillchars+=vert:│
highlight VertSplit cterm=NONE ctermfg=12

" remove latex concealment
let g:tex_conceal = ""

" remove vimtex vim version warning
let g:vimtex_version_check = 0

" highlight characters after column 80
highlight OverLength ctermbg=darkgray ctermfg=black
" match OverLength /\%81v.\+/

" darken tildes at EOF
highlight EndOfBuffer ctermfg=16

" pop-up menu colors
highlight Pmenu ctermbg=0 ctermfg=7
highlight PmenuSel ctermbg=7 ctermfg=0
highlight PmenuSbar ctermbg=grey
highlight PmenuThumb ctermbg=blue

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
autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType java setlocal shiftwidth=4
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType python setlocal shiftwidth=4
autocmd FileType vim setlocal shiftwidth=4
autocmd FileType sql setlocal shiftwidth=4
autocmd FileType lua setlocal shiftwidth=4
autocmd FileType fish setlocal shiftwidth=4 | ALEDisable
autocmd FileType sh setlocal shiftwidth=8
" add to gray out text after column 80
" | match OverLength /\%81v.\+/

"-------------------------"
" General Vim Keybindings "
"-------------------------"

" map the leader key
let mapleader=','
" remove leader timeout
set notimeout
set ttimeout
" cancel leader command
nnoremap <leader>, jk

" map :up and :q
noremap <silent> <leader>w :up<CR>
noremap <leader>q :q<CR>

" update buffer
noremap <leader>r :edit!<CR>

" map buffer navigation keys
nnoremap <silent> - :bprevious<CR>
nnoremap <silent> = :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>

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

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gr :Git restore %<CR>
nmap <leader>gj <Plug>(GitGutterNextHunk)
nmap <leader>gk <Plug>(GitGutterPrevHunk)
" nnoremap <leader>gu :Gpush<CR>
" nnoremap <leader>gd :Gpull<CR>

highlight GitGutterAdd    ctermfg=7
highlight GitGutterChange ctermfg=7
highlight GitGutterDelete ctermfg=7
" let g:gitgutter_sign_added = '++'
" let g:gitgutter_sign_modified = '~~'
" let g:gitgutter_sign_removed = '--'

" Terminal settings !!!!!

" split-term.vim settings
set splitright
let g:term_size = 50

" terminal function (from /u/andreyorst) was modified
let g:term_buf = -1
let g:term_win = 0
function! TermToggle()
    if win_gotoid(g:term_win) || g:term_buf == bufnr("")
        hide
    else
        if bufexists(g:term_buf) == 1
            exec g:term_size "vsplit | buffer " g:term_buf
            let g:term_win = win_getid()
        else
            exec g:term_size "VTerm"
            set nonumber
            set norelativenumber
            set signcolumn=no
            " hides the buffer from airline's tabline
            setlocal nobuflisted
            let g:term_buf = bufnr("")
            let g:term_win = win_getid()
        endif
        startinsert!
    endif
endfunction
" switch to terminal window function (from me)
function! TermSwitch()
    if g:term_win == win_getid()
        exec "vertical resize " g:term_size
        exec "wincmd h"
    else
        if win_gotoid(g:term_win)
            exec "vertical resize " g:term_size
            startinsert!
        endif
    endif
endfunction

" exit terminal window if it is the last window
autocmd bufenter * if winnr("$") == 1 && win_getid() == g:term_win | q | endif

" terminal bindings
" nnoremap <silent> <leader>tt :call TermToggle()<CR>
" tnoremap <silent> <leader>tt <C-\><C-n>:call TermToggle()<CR>
" nnoremap <silent> <leader>ts :call TermSwitch()<CR>
" tnoremap <silent> <leader>ts <C-\><C-n>:call TermSwitch()<CR>
" nnoremap <silent> <leader>t :call TermToggle()<CR>
" tnoremap <silent> <leader>t <C-\><C-n>:call TermToggle()<CR>
" tnoremap <silent> <C-h> <C-\><C-n>:wincmd h<CR>
" autocmd BufWinEnter,WinEnter term://* startinsert

" indent line
let g:indentLine_char = '▏'
" let g:indentLine_color_term = 7

" highlight word under cursor
highlight link illuminatedWord Visual
let g:Illuminate_ftblacklist = [ 'help', 'defx', 'vista_kind', 'vim', 'markdown', 'tex', 'vimwiki' ]
" nnoremap <leader>hl :IlluminationToggle<CR>

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
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_gopls_enabled = 0
let g:go_template_use_pkg = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_fmt_autosave = 0

" minimap
let g:minimap_auto_start = 1
let g:minimap_width = 20
