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

vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        name = "nvim-treesitter-textobjects",
    },
})

local include_surrounding_whitespace = true

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "v",
            ["@class.outer"] = "v",
        },
        include_surrounding_whitespace = include_surrounding_whitespace,
    },
})

local function select_textobject(capture)
    return function()
        require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
    end
end

local function map(lhs, capture, desc)
    vim.keymap.set({"x", "o"}, lhs, select_textobject(capture), {
        desc = desc,
        silent = true,
    })
end

-- A = argument
map("aa", "@parameter.outer", "Outer argument")
map("ia", "@parameter.inner", "Inner argument")

-- B = block
map("aB", "@block.outer", "Outer block")
map("iB", "@block.inner", "Inner block")

-- C = class
map("ac", "@class.outer", "Outer class")
map("ic", "@class.inner", "Inner class")

-- D = function call
map("ad", "@call.outer", "Outer call")
map("id", "@call.inner", "Inner call")

-- F = function
map("af", "@function.outer", "Outer function")
map("if", "@function.inner", "Inner function")

-- T = test / conditional
-- NOTE: cit used for change inner tag (in html)
map("aT", "@conditional.outer", "Outer conditional")
map("iT", "@conditional.inner", "Inner conditional")

-- R = return
map("ar", "@return.outer", "Outer return")
map("ir", "@return.inner", "Inner return")

-- X = attribute / decorator
map("ax", "@attribute.outer", "Outer attribute")
map("ix", "@attribute.inner", "Inner attribute")

-- S = comment / saying
map("as", "@comment.outer", "Outer comment")
map("is", "@comment.inner", "Inner comment")

-- K = statement / kode line
map("ak", "@statement.outer", "Outer statement")

-- V = scope value, for example function/class name
map("av", "@scopename.inner", "Scope name")

-- Assignments
map("i=", "@assignment.inner", "Inner assignment")
map("a=", "@assignment.outer", "Outer assignment")
map("ik", "@assignment.lhs", "Assignment lhs")
map("iv", "@assignment.rhs", "Assignment rhs")
