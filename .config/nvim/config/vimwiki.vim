" Wiki List
let g:vimwiki_list = [{'path': '~/wiki/payment'}]

" Remap Global Defaults
let g:vimwiki_map_prefix = '<Leader>v'
nmap + <Plug>VimwikiAddHeaderLevel
nmap _ <Plug>VimwikiRemoveHeaderLevel
nmap ) <Plug>VimwikiNormalizeLink

" Allow Folding
let g:vimwiki_folding = 'list'
