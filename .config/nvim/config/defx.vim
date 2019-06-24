" defx

nnoremap <silent> <leader>n :Defx<CR>:ConoLineToggle<CR>

let g:defx_icons_column_length = 2

call defx#custom#option('_', {
\ 'winwidth': 38,
\ 'split': 'vertical',
\ 'direction': 'topleft',
\ 'columns': 'indent:git:icons:filename:type',
\ 'show_ignored_files': 0,
\ 'toggle': 1,
\ })

"close defx if it's the only buffer left in the window
autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif

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
    \ defx#do_action('drop')
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
  nnoremap <silent><buffer><expr> zh
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
  nnoremap <silent><buffer><expr> <C-r>
    \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
    \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
endfunction
