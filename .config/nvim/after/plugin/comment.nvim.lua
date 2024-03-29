if not require("namespace.utils").get_is_installed("Comment.nvim") then return end

require('Comment').setup(
{
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap, e.g. in javascript //
        line = '<leader>jl',
        ---Block-comment toggle keymap, e.g. in javascript /* .. */
        block = '<leader>jL',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<leader>j', -- NICE
        ---Block-comment keymap
        block = '<leader>J', -- NICE
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = '<leader>jK',
        ---Add comment on the line below
        below = '<leader>jJ',
        ---Add comment at the end of line
        eol = '<leader>jA',
    },
})

-- Use Javascript style comments in HTML files
local ft = require('Comment.ft')
ft.set('html', {'//%s', '/*%s*/'})
ft.set('htmldjango', {'//%s', '/*%s*/'})
