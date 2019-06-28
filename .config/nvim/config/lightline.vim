" Lightline

set laststatus=2
set showtabline=2
set noshowmode

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ }

let g:lightline.active = {
            \ 'left': [ [ 'mode' ],
            \           [ 'spell', 'readonly', 'filename' ],
            \           [ 'filetype' ] ],
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lineinfo' ],
            \            [ 'noscrollbar' ],
            \            [ 'tagbar' ] ]
            \ }

let g:lightline.inactive = {
            \ 'left': [ [ 'mode' ],
            \           [ 'spell', 'readonly', 'filename' ],
            \           [ ] ],
            \ 'right': [ [ ],
            \            [ ] ]
            \ }

let g:lightline.component = {
            \   'lineinfo': '%1l:%-2v',
            \   'line': '%l',
            \   'column': '%c',
            \}

let g:lightline.component_function = {
            \   'filename': 'LightlineFilename',
            \   'filetype': 'LightlineFiletype',
            \   'readonly': 'LightlineReadonly',
            \   'noscrollbar': 'Noscrollbar',
            \   'tagbar': 'LightlineTagbar',
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
let g:lightline#bufferline#modified = ' +'
let g:lightline#bufferline#read_only = ' '
let g:lightline#bufferline#enable_devicons = 0

" let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#number_map = {
" \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
" \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
" nmap <Leader>1 <Plug>lightline#bufferline#go(1)
" nmap <Leader>2 <Plug>lightline#bufferline#go(2)
" nmap <Leader>3 <Plug>lightline#bufferline#go(3)
" nmap <Leader>4 <Plug>lightline#bufferline#go(4)
" nmap <Leader>5 <Plug>lightline#bufferline#go(5)
" nmap <Leader>6 <Plug>lightline#bufferline#go(6)
" nmap <Leader>7 <Plug>lightline#bufferline#go(7)
" nmap <Leader>8 <Plug>lightline#bufferline#go(8)
" nmap <Leader>9 <Plug>lightline#bufferline#go(9)
" nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" Filename
function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" Filetype
function! LightlineFiletype()
    return winwidth(0) > 50 ? (&filetype !=# '' ? &filetype : 'no filetype') : ''
endfunction

" Readonly
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

" Tagbar
function! LightlineTagbar()
    return winwidth(0) > 80 ? tagbar#currenttag("%s", "") : ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0

" Max Filename Length
let g:lightline_buffer_maxflen = 30

" ALE Lightline
let g:lightline#ale#indicator_checking = "..."
let g:lightline#ale#indicator_warnings = "\uf071 :"
let g:lightline#ale#indicator_errors = "\uf05e :"
let g:lightline#ale#indicator_ok = "  "

" Lightline noscrollbar
function! Noscrollbar(...)
    return winwidth(0) > 80 ? (' ' . noscrollbar#statusline()) : ''
    return ' ' . noscrollbar#statusline()
endfunction
