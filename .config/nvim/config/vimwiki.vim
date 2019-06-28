" Wiki List
let g:vimwiki_list = [{'path': '~/wiki'}]

" Remap Global Defaults
let g:vimwiki_map_prefix = '<Leader>v'
nmap + <Plug>VimwikiAddHeaderLevel
nmap _ <Plug>VimwikiRemoveHeaderLevel
nmap ) <Plug>VimwikiNormalizeLink

" Allow Folding
let g:vimwiki_folding = 'list'

function! VimwikiLinkHandler(link)
    " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
    "   1) [[vfile:~/Code/PythonProject/abc123.py]]
    "   2) [[vfile:./|Wiki Home]]
    let link = a:link
    if link =~# '^vfile:'
        let link = link[1:]
    else
        return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'edit ' . fnameescape(link_infos.filename)
        return 1
    endif
endfunction
