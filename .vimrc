" pathogen
execute pathogen#infect()

" Change clipboard register for vim
set clipboard=unnamedplus

" Important settings
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set hidden

" Line numbers
set number relativenumber

" Visual Wrapping
set nowrap

" Mode switch delay
set timeoutlen=1000 ttimeoutlen=0

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable spell check functionality
set spelllang=en

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Map buffer navigation keys
nnoremap - :bprevious<ENTER>
nnoremap = :bnext<ENTER>

" Remove pane pipes
:set fillchars+=vert:\ 

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

" replace powerline fonts if they are missing
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"let g:airline_symbols.space = "\ua0"

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>

" tagbar
nnoremap <C-o> :TagbarToggle<CR> <bar> <C-w>w
let g:tagbar_show_linenumbers = 2
let g:tagbar_iconchars = ['▸', '▾']

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

" remove latex concealment
let g:tex_conceal = ""
