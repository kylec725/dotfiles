"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
" Airline to replace status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
" Plug 'Yggdroot/indentLine'
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
Plug 'tbastos/vim-lua'
" Documentation integration
Plug 'KabbAmine/zeavim.vim'
" Position indicator
Plug 'gcavallanti/vim-noscrollbar'
" Nord colorscheme (only used for airline)
Plug 'arcticicestudio/nord-vim'
Plug 'vimlab/split-term.vim'
" fzf
Plug 'junegunn/fzf.vim'
call plug#end()

"----------------------"
" General Vim Settings "
"----------------------"

" Change clipboard register for vim
set clipboard=unnamedplus

" Important settings
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set hidden

" enable .h files to be set to filetype c
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" indent settings
set expandtab
set softtabstop=-1

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

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable spell check functionality
set spelllang=en

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

"-------------------------"
" General Vim Keybindings "
"-------------------------"

" map the leader key
let mapleader=','

" map :w and :q
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" map buffer navigation keys
nnoremap <silent> - :bprevious<CR>
nnoremap <silent> = :bnext<CR>
" nnoremap <silent> <C-h> :bprevious<CR>
" nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>

" map shift + hjkl
nnoremap <S-h> ^
nnoremap <S-j> L
nnoremap <S-k> H
nnoremap <S-L> g_
vnoremap <S-h> ^
vnoremap <S-j> L
vnoremap <S-k> H
vnoremap <S-L> g_

" window navigation keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l

" window resize keys
" nnoremap <silent> <C-y> :vertical resize -5<CR>
" nnoremap <silent> <C-u> :resize -5<CR>
" nnoremap <silent> <C-i> :resize +5<CR>
" nnoremap <silent> <C-o> :vertical resize +5<CR>
" vnoremap <silent> <C-y> :vertical resize -5<CR>
" vnoremap <silent> <C-u> :resize -5<CR>
" vnoremap <silent> <C-i> :resize +5<CR>
" vnoremap <silent> <C-o> :vertical resize +5<CR>

" make Y behave like C and D
nnoremap Y y$

" <S-e> to backwards end of word
nnoremap <S-e> ge
vnoremap <S-e> ge

"replace the word under cursor
nnoremap <leader>s :%s/\<<c-r><c-w>\>//g<left><left>

"-----------------"
" Plugin Settings "
"-----------------"

" Airline !!!!!

let g:airline_extensions = ["tabline", "branch", "ale", "hunks"]
set laststatus=2
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

" Nerdtree !!!!!

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:nerd_win = 0
" function to toggle nerdtree but track window id
" function! NerdToggle()
"     NERDTreeToggle
"     let g:nerd_win = win_getid()
" endfunction
" function to switch between last window and nerdtree
" function! NerdSwitch()
"     if g:nerd_win == win_getid()
"         wincmd l
"     else
"         wincmd h
"         " call win_gotoid(g:nerd_win)
"     endif
" endfunction
" nerdtree mappings
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
" nnoremap <silent> <leader>ns :exec NerdSwitch()<CR>

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

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
nnoremap <LEADER>a :ALEDetail<CR>

" Noscrollbar !!!!!

function! Noscrollbar(...)
    let w:airline_section_z = '%{noscrollbar#statusline()} :%2c'
endfunction
call airline#add_statusline_func('Noscrollbar')

" Fugitive !!!!!

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
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
tnoremap <leader>f :Files<CR>
nnoremap <leader>l <C-\><C-n>:Lines<CR>
tnoremap <leader>l <C-\><C-n>:Lines<CR>

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
