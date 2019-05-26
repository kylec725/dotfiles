"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'bling/vim-airline'
" Airline to replace status line
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
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
hi CursorLineNR ctermfg=lightgreen

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable spell check functionality
set spelllang=en

" Map buffer navigation keys
nnoremap - :bprevious<ENTER>
nnoremap = :bnext<ENTER>

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Visual Wrapping
set nowrap

" Clear SignColumn/Gutter color
hi clear SignColumn

" Cursor
set guicursor=a:blinkon100

" Remove pane pipes
:set fillchars+=vert:\ 

" remove latex concealment
let g:tex_conceal = ""

"-----------------"
" Plugin Settings "
"-----------------"

" vim airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='term'
let g:airline_detect_paste=1
set encoding=utf-8
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
let g:airline_powerline_fonts = 1
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

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>

" tagbar
" nnoremap <C-o> :TagbarToggle<CR> <bar> <C-w>w
" let g:tagbar_show_linenumbers = 2
" let g:tagbar_iconchars = ['▸', '▾']

" goyo
function! s:goyo_enter()
	set wrap
endfunction

function! s:goyo_leave()
	set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <C-g> :Goyo<CR>

" indent guide
let g:indentLine_char = '▏'

" coc.vim settings
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" assign tab and s-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" lint after leaving insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" noscrollbar
" let g:airline_section_x = '%{&filetype}'
" let g:airline_section_y = '%#__accent_bold#%{noscrollbar#statusline()}%#__restore__#'
" let g:airline_section_z = ':%2c'
    function! Noscrollbar(...)
        let w:airline_section_z = '%{noscrollbar#statusline()} :%2c'
    endfunction
    call airline#add_statusline_func('Noscrollbar')
