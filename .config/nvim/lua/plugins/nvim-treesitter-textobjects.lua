-- @assignment.inner
-- @assignment.lhs
-- @assignment.outer
-- @assignment.rhs
-- @attribute.inner / Decorators for py/js
-- @attribute.outer
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @comment.inner
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner
-- @frame.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @number.inner
-- @parameter.inner
-- @parameter.outer
-- @regex.inner
-- @regex.outer
-- @return.inner
-- @return.outer
-- @scopename.inner
-- @statement.outer

local Plugin = {
    "nvim-treesitter-textobjects",
}

local function include_surrounding_whitespace(ctx)
    local q = ctx.query_string
    local include_whitespace = {
        ['@assignment.inner'] = false,
        ['@assignment.lhs']   = false,
        ['@assignment.outer'] = true,
        ['@assignment.rhs']   = false,
        ['@attribute.inner']  = false,
        ['@attribute.outer']  = false,
        ['@block.inner']      = false,
        ['@block.outer']      = true,
        ['@call.inner']       = false,
        ['@call.outer']       = false,
        ['@class.inner']      = false,
        ['@class.outer']      = true,
        ['@comment.inner']    = false,
        ['@comment.outer']    = false,
        ['@conditional.inner'] = false,
        ['@conditional.outer'] = true,
        ['@frame.inner']      = false,
        ['@frame.outer']      = true,
        ['@function.inner']   = false,
        ['@function.outer']   = true,
        ['@loop.inner']       = false,
        ['@loop.outer']       = true,
        ['@number.inner']     = false,
        ['@parameter.inner']  = false,
        ['@parameter.outer']  = false,
        ['@regex.inner']      = false,
        ['@regex.outer']      = false,
        ['@return.inner']     = false,
        ['@return.outer']     = true,
        ['@scopename.inner']  = false,
        ['@statement.outer']  = true,
    }
    local include = include_whitespace[q]
    if include == nil then
        return false
    else
        return include
    end
end

Plugin.config = function()
    require'nvim-treesitter.configs'.setup {
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    -- Arguments from some other plugin?

                    -- A = (A)rgument
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    -- B = (B)lock
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    -- C = (c)lass
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    -- D = Do.. as in a function call()
                    ["ad"] = "@call.outer",
                    ["id"] = "@call.inner",
                    -- F = (F)unction
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    -- T = (T)est (conditional/predicate)
                    ["at"] = "@conditional.outer",
                    ["it"] = "@conditional.inner",
                    -- R = (R)eturn
                    ["ar"] = "@return.outer",
                    ["ir"] = "@return.inner",
                    -- X = Attributes
                    ["ax"] = "@attribute.outer",
                    ["ix"] = "@attribute.inner",
                    -- S = comment or (S)ayings
                    ["as"] = "@comment.outer",
                    ["is"] = "@comment.inner",
                    --
                    ["ak"] = "@statement.outer", -- A (K)ode line, note ik = assignment LHS
                    ["av"] = "@scopename.inner", -- A scope (V)alue (e.g. function/class name), note iv = assignment RHS
                    -- Assignments
                    ["i="] = "@assignment.inner",
                    ["a="] = "@assignment.outer",
                    ["ik"] = "@assignment.lhs", -- (K)ey
                    ["iv"] = "@assignment.rhs", -- (V)value
                    -- FREE: e h j r s u w x y A B C D E F G H J K L M O P Q R T U V W X Y Z
                    -- p = paragraph
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
                    -- ['@function.outer'] = 'V', -- linewise, WARNING!!! Dont combine with 'include_surrounding_whitespace = true' cause then will select the next signature
                    ['@function.outer'] = 'v', -- charwise
                    ['@class.outer'] = 'v', -- blockwise
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
                include_surrounding_whitespace = include_surrounding_whitespace,
            },
        },
    }
end

return Plugin
