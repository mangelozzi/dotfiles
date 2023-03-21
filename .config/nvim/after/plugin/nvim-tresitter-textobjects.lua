if not require("namespace.utils").get_is_installed("nvim-treesitter") then return end
if not require("namespace.utils").get_is_installed("nvim-treesitter-textobjects") then return end

-- @attribute.inner
-- @attribute.outer
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner
-- @frame.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @number.inner
-- @regex.inner
-- @regex.outer
-- @scopename.inner
-- @statement.outer
-- @parameter.inner
-- @parameter.outer

require'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                -- Arguments from some other plugin?
                -- functions
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- classes
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- Assignments
                -- available: @assignment.lhs
                ["i="] = "@assignment.inner",
                ["a="] = "@assignment.outer",
                ["a+"] = "@assignment.rhs",
                ["am"] = "@comment.outer",
                ["im"] = "@comment.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
        },
    },
}
