vim.pack.add {
    {
        src = "https://codeberg.org/andyg/leap.nvim"
    }
}

local leap = require("leap")

vim.keymap.set(
    "n",
    "<cr>",
    function()
        leap.leap {
            target_windows = require("leap.user").get_focusable_windows()
        }
    end,
    {desc = "Leap"}
)

-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group.
leap.opts.equivalence_classes = {" \t\r\n", "([{", ")]}", '\'"`'}
leap.opts.vim_opts["go.ignorecase"] = false

-- Override some old defaults - use backspace instead of tab (see issue #165).
leap.opts.special_keys.prev_target = "<backspace>"
leap.opts.special_keys.prev_group = "<backspace>"
