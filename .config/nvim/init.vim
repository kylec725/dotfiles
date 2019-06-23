"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'junegunn/goyo.vim'
" Plug 'bling/vim-airline'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sinetoami/lightline-hunks'
Plug 'maximbaz/lightline-ale'
Plug 'ryanoasis/vim-devicons'

Plug 'liuchengxu/vista.vim'
Plug 'tomtom/tcomment_vim'
Plug 'Yggdroot/indentLine'
Plug 'gregsexton/MatchTag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'octol/vim-cpp-enhanced-highlight'
" Intellisense engine
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'w0rp/ale'
" Show git status in gutter
Plug 'airblade/vim-gitgutter'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Language pack support
Plug 'sheerun/vim-polyglot'
" Documentation integration
Plug 'KabbAmine/zeavim.vim'
" Position indicator
Plug 'gcavallanti/vim-noscrollbar'
" Nord colorscheme (only used for airline)
Plug 'arcticicestudio/nord-vim'
Plug 'vimlab/split-term.vim'
" fzf
Plug 'junegunn/fzf.vim'
" Highlight current line
Plug 'miyakogi/conoline.vim'
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
hi LineNr ctermfg=12
hi CursorLineNR ctermfg=11

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
hi Search ctermbg=yellow ctermfg=black
" highlight current search match in different color
hi IncSearch ctermbg=black ctermfg=magenta

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Visual Wrapping
set nowrap

" Clear SignColumn/Gutter color
hi clear SignColumn

" Cursor blinking
set guicursor=a:blinkon100

" Change window pane separator to a single line
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermfg=12

" remove latex concealment
let g:tex_conceal = ""

" highlight characters after column 80
highlight OverLength ctermbg=darkgray ctermfg=black
" match OverLength /\%81v.\+/

" darken tildes at EOF
hi EndOfBuffer ctermfg=16

" indent settings
set tabstop=8
set expandtab
set softtabstop=-1
" auto indent command
command Indent :normal! MmQgg=G'Qzz
" filetype indent settings
autocmd FileType html setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType css setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType json setlocal shiftwidth=2
autocmd FileType ruby setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType tex setlocal shiftwidth=2 spell | nnoremap <leader>p :!pdflatex %<CR>
autocmd FileType markdown setlocal spell
autocmd FileType ocaml setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType c setlocal shiftwidth=4 cindent | match OverLength /\%81v.\+/
autocmd FileType cpp setlocal shiftwidth=4 cindent cinoptions=g0+N-sw | match OverLength /\%81v.\+/
autocmd FileType java setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType javascript setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType python setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType vim setlocal shiftwidth=4
autocmd FileType lua setlocal shiftwidth=4
autocmd FileType fish setlocal shiftwidth=4 | ALEDisable
autocmd FileType sh setlocal shiftwidth=8

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

" map :w and :q
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>

" map buffer navigation keys
nnoremap <silent> - :bprevious<CR>
nnoremap <silent> = :bnext<CR>
" nnoremap <silent> <C-h> :bprevious<CR>
" nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>

" map shift + hjkl
noremap <S-h> ^
noremap <S-j> 3j
noremap <S-k> 3k
noremap <S-L> g_

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

" <S-e> to backwards end of word
noremap <S-e> ge

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
nnoremap <silent><CR> o<Esc>k

"-----------------"
" Plugin Settings "
"-----------------"

" Airline !!!!!

let g:airline_extensions = ["tabline", "branch", "ale", "hunks"]
set laststatus=2
set noshowmode
set showtabline=2
" let g:airline_theme='term'
let g:airline_theme='nord'
let g:airline_detect_paste=1
set encoding=utf-8
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#ale#enabled = 1

" replace powerline fonts if they are missing
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.dirty='⚡'
let g:airline_symbols.dirty=''
let g:airline_symbols.notexists = ''
"let g:airline_symbols.space = "\ua0"

" Lightline !!!!!

let g:lightline = {
    \ 'colorscheme': 'nord',
    \ }

let g:lightline.active = {
    \ 'left': [ [ 'mode' ],
    \           [ 'spell', 'readonly', 'filename', 'modified' ],
    \           [ 'filetype' ] ],
    \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lineinfo' ],
    \            [ 'noscrollbar' ],
    \            [ 'nearest' ] ]
    \ }

let g:lightline.inactive = {
    \ 'left': [ [  ],
    \           [ 'spell', 'readonly', 'filename', 'modified' ],
    \           [ 'filetype' ] ],
    \ 'right': [ [ ],
    \            [ ] ]
    \ }

let g:lightline.component = {
    \   'lineinfo': '%1l:%-2v',
    \   'line': '%l',
    \   'column': '%c',
    \}

let g:lightline.component_function = {
    \   'noscrollbar': 'Noscrollbar',
    \   'nearest': 'NearestMethodOrFunction'
    \ }

let g:lightline.component_expand = {
    \   'hunks': 'lightline#hunks#composer',
    \   'buffers': 'lightline#bufferline#buffers',
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \}

let g:lightline.component_type   = {
    \   'buffers': 'tabsel',
    \   'linter_checking': 'left',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'left',
    \   'hunks': 'tabsel',
    \}

let g:lightline.tabline = {
    \ 'left': [ [ 'buffers' ] ],
    \ 'right': [ [ 'hunks' ] ] }

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

" Bufferline
function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '•'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_separator_icon = '  '

" max file name length
let g:lightline_buffer_maxflen = 30

" ALE Lightline
let g:lightline#ale#indicator_checking = "..."
let g:lightline#ale#indicator_warnings = "\uf071 :"
let g:lightline#ale#indicator_errors = "\uf05e :"

" Lightline noscrollbar
function! Noscrollbar(...)
    return ' ' . noscrollbar#statusline()
endfunction

" Nearest function
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Nerdtree !!!!!

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:nerd_win = 0
" let NERDTreeMinimalUI=1
" nerdtree mappings
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

" Goyo !!!!!

function! s:goyo_enter()
    set wrap
endfunction

function! s:goyo_leave()
    set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <C-g> :Goyo<CR>

" Coc !!!!!

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" assign tab and s-tab to cycle through suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ale !!!!!

nnoremap <LEADER>ad :ALEDetail<CR>
nmap <leader>aj <Plug>(ale_next_wrap)
nmap <leader>ak <Plug>(ale_previous_wrap)
" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Noscrollbar !!!!!

" function! Noscrollbar(...)
"     let w:airline_section_z = '%{noscrollbar#statusline()} %l:%c'
" endfunction
" call airline#add_statusline_func('Noscrollbar')

" Git Commands - Fugitive and Gitgutter !!!!!

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk
" nnoremap <leader>gu :Gpush<CR>
" nnoremap <leader>gd :Gpull<CR>

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
nnoremap <silent> <leader>tt :call TermToggle()<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:call TermToggle()<CR>
nnoremap <silent> <leader>ts :call TermSwitch()<CR>
tnoremap <silent> <leader>ts <C-\><C-n>:call TermSwitch()<CR>

" fzf settings !!!!!
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" hide the statusline when searching
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <leader>f :Files<CR>
nnoremap <leader>l :Lines<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" indent line
let g:indentLine_char = '▏'

" Conoline settings !!!!!
let g:conoline_auto_enable = 0
let g:conoline_color_normal_dark = 'ctermbg=black'
let g:conoline_color_normal_nr_dark = 'ctermfg=11'
let g:conoline_color_insert_dark = 'ctermbg=black'
let g:conoline_color_insert_nr_dark = 'ctermfg=11'
nnoremap <silent> <leader>c :ConoLineToggle<CR>

" Vista
nnoremap <silent> <leader>v :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista_stay_on_open = 0

" Defx
nnoremap <silent> <leader>n :Defx<CR>

let g:defx_icons_column_length = 2

call defx#custom#option('_', {
\ 'winwidth': 35,
\ 'split': 'vertical',
\ 'direction': 'topleft',
\ 'columns': 'indent:git:icons:filename:type',
\ 'show_ignored_files': 0,
\ 'toggle': 1,
\ })

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr>
    \<CR> defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
    \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
    \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
    \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
    \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> D
    \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
    \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
    \ defx#do_action('toggle_columns',
    \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
    \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
    \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
    \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
    \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
    \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
endfunction
