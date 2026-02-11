--[[
https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file

<count>ai	An Indentation level and line above.
<count>ii	Inner Indentation level (no line above).
<count>aI	An Indentation level and lines above/below.

R           restOfIndentation - lines down with same or higher indentation

iS/aS       Sub word - for camelCase processing

C           toNextClosingBracket
Q           toNextQuotationMark

gG          Entire buffer
n           nearEoL *DISABLED - Rather keep n for next match
in/an       number

ic/ac       cssSelector
i#/a#       cssColor
ix/ax       Html Attribute *DISABLED - Using nvim-treesitter-textobjects instead
g;          lastChange

ik/ak       key or lhs of assignment
iv/av       value or rhs of assignment
column      |       <- Brillant

im/am       chainMember - Section of a chain connected with . (or :) like foo.bar or foo.baz(param).
--]]

local Plugin = {
    "chrisgrieser/nvim-various-textobjs",
}

Plugin.config = function()
    require("various-textobjs").setup({
        -- set to 0 to only look in the current line
        lookForwardSmall = 5,
        lookForwardBig = 15,

        -- use suggested keymaps (see overview table in README)
        useDefaultKeymaps = true,

        -- disable only some default keymaps, e.g. { "ai", "ii" }
        disabledKeymaps = {
            "il", -- markdown link titles - rather use for own inner line
            "al", -- markdown link titles - rather use for own a line
            "gw", -- visibleInWindow - smashes the built v_gw command for wrapping text
            "L",  -- in visual mode use L to goto bottom
            "n",  -- nearEoL - interfers with delete until next match
            "ax", -- using nvim-treesitter-textobjects instead
            "ix", -- using nvim-treesitter-textobjects instead
            "ak", -- using nvim-treesitter-textobjects instead
            "ik", -- using nvim-treesitter-textobjects instead
            "av", -- using nvim-treesitter-textobjects instead
            "iv", -- using nvim-treesitter-textobjects instead
        },

        -- display notifications if a text object is not found
        notifyNotFound = true,
        keys = {
        },
    })

    -- Own map preserves the cursor position
    -- vim.keymap.set({ "o", "x" }, "al", '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<CR>')
    -- vim.keymap.set({ "o", "x" }, "il", '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<CR>')

    -- Own way prefers the position of the cursor on copy all
    -- vim.keymap.set({ "o", "x" }, "A", '<cmd>lua require("various-textobjs").entireBuffer()<CR>')
end

return Plugin
