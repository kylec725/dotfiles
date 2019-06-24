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
            \   'tagbar': '%{tagbar#currenttag("%s", "")}',
            \}

let g:lightline.component_function = {
            \   'filename': 'LightlineFilename',
            \   'filetype': 'LightlineFiletype',
            \   'noscrollbar': 'Noscrollbar',
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

" Filename
function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" Filetype
function! LightlineFiletype()
    return winwidth(0) > 50 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" Max Filename Length
let g:lightline_buffer_maxflen = 30

" ALE Lightline
let g:lightline#ale#indicator_checking = "..."
let g:lightline#ale#indicator_warnings = "\uf071 :"
let g:lightline#ale#indicator_errors = "\uf05e :"
let g:lightline#ale#indicator_ok = "  "

" Lightline noscrollbar
function! Noscrollbar(...)
    return winwidth(0) > 50 ? (' ' . noscrollbar#statusline()) : ''
    return ' ' . noscrollbar#statusline()
endfunction
