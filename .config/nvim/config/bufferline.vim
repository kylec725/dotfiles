" lua require('bufferline').setup{}

nnoremap <silent>- :BufferLineCyclePrev<CR>
nnoremap <silent>= :BufferLineCycleNext<CR>
" use vim-bbye
nnoremap <silent> <leader>bd :Bdelete<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent>_ :BufferLineMovePrev<CR>
nnoremap <silent>+ :BufferLineMoveNext<CR>

lua << EOF
require('bufferline').setup {
    options = {
        numbers = "none",
        numbers = function(opts)
            return ''
        end,
        -- mappings = false,
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        left_mouse_command = nil,    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        -- indicator_icon = '▎',
        indicator_icon = '▶',
        buffer_close_icon = '',
        modified_icon = '⏺',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
        -- remove extension from markdown files for example
        -- if buf.name:match('%.md') then
        --     return vim.fn.fnamemodify(buf.name, ':t:r')
        -- end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
    -- filter out filetypes you don't want to see
    if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
    end
    -- filter out by buffer name
    if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
    end
    -- filter out based on arbitrary rules
    -- e.g. filter out vim wiki buffer from tabline in your work repo
    if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
    end
end,
offsets = {{filetype = "fern", text = "File Explorer" , text_align = "center"}},
    show_buffer_icons = false, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
    separator_style = { '', '' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id',
    },
highlights = {
    indicator_selected = {
        guifg = '#719cd6',
        },
    buffer_selected = {
        gui = "bold"
        }
    }
}
EOF
