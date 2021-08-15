" fzf

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" hide the statusline when searching
" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" nnoremap <leader>af :Files!<CR>
" nnoremap <leader>f :GFiles!<CR>
" nnoremap <leader>l :Lines!<CR>
nnoremap <silent> <leader>af :call fzf#vim#files('.', {'options': '--reverse --margin=3,8 --prompt ""'})<CR>
nnoremap <silent> <leader>f :call fzf#vim#gitfiles('.', {'options': '--reverse --margin=3,8 --prompt ""'})<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'PreProc'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
  " \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  " \ 'bg+':     ['bg', 'Normal'],
  " \ 'info':    ['fg', 'PreProc'],

" Floating Window Settings

let $FZF_DEFAULT_OPTS='--no-mouse --bind=tab:down,btab:up --color=prompt:195,pointer:#5ADECD,hl+:#5ADECD,hl:#C574DD,info:#152238,bg+:#152238,fg+:#FFFFFF,gutter:-1'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 80% of the height
  let height = float2nr(&lines * 0.6)
  " 60% of the width
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (centralized)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  " open the new window, floating, and enter to it
  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:FZFFloat') " FZFFloat is set in init.vim
endfunction
