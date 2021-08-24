lua << EOF
local nightfox = require('nightfox')
local colors = require('nightfox.colors').load()

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
    fox = "nightfox", -- Which fox style should be applied
    transparent = true, -- Disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening :terminal
    styles = {
        comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
        functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
        keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
        strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
        variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
        },
    colors = {}, -- Override default colors
    hlgroups = {
        NormalFloat = "NONE",
        }, -- Override highlight groups
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
EOF

" trying to overwrite using lua config does not work
highlight FloatBorder ctermbg=NONE guibg=NONE ctermfg=white guifg=#dfdfe0
