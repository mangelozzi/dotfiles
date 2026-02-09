--[[
Upper case      LOREM IPSUM   textcase.api.to_constant_case u
Lower case      lorem ipsum   textcase.api.to_lower_case    l
Snake case      lorem_ipsum   textcase.api.to_snake_case    s
Dash case       lorem-ipsum   textcase.api.to_dash_case     d -> changed to k for kebab-case
Constant case   LOREM_IPSUM   textcase.api.to_constant_case n
Camel case      loremIpsum    textcase.api.to_camel_case    c
Pascal case     LoremIpsum    textcase.api.to_pascal_case   p

I mapped these (by default they are unmapped, refer to: https://github.com/johmsalas/text-case.nvim/issues/171):
Dot case        lorem.ipsum   textcase.api.to_dot_case      d
Title case      Lorem Ipsum   textcase.api.to_title_case    t
Path case       lorem/ipsum   textcase.api.to_path_case     /
Phrase case     Lorem ipsum   textcase.api.to_phrase_case   <space>

Operator, e.g. make the text within " title case:
gaot i"
    - gaot - ga-operator-titlecase
    - i" - inner "..."
--]]

local Plugin = {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
}

Plugin.config = function()
    require("textcase").setup{
        -- Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
        default_keymappings_enabled = true,
        -- `prefix` is only considered if `default_keymappings_enabled` is true. It configures the prefix
        -- of the keymappings, e.g. `gau ` executes the `current_word` method with `to_upper_case`
        -- and `gaou` executes the `operator` method with `to_upper_case`.
        prefix = "ga",
        -- If `substitude_command_name` is not nil, an additional command with the passed in name
        -- will be created that does the same thing as "Subs" does.
        substitude_command_name = 'S',
    }

    -- Common function to set up mappings for each case
    local function setup_textcase_keymaps(key, case, desc, op_desc)
        -- Normal mode: Convert current word
        vim.keymap.set('n', 'ga' .. key, function() require('textcase').current_word(case) end, { noremap = true, silent = true, desc = "Convert to " .. desc })
        -- Normal mode: LSP rename
        vim.keymap.set('n', 'ga' .. key:upper(), function() require('textcase').current_word(case) end, { noremap = true, silent = true, desc = "LSP rename to " .. desc })
        -- Normal mode: Operator
        vim.keymap.set('n', 'gao' .. key, function() require('textcase').operator(case) end, { noremap = true, silent = true, desc = op_desc })
        -- Visual mode: Operator
        vim.keymap.set('x', 'ga' .. key, function() require('textcase').operator(case) end, { noremap = true, silent = true, desc = "Convert to " .. desc })
    end

    -- Define key mappings for various cases
    setup_textcase_keymaps('_', 'to_snake_case', '_ (snake-case)', 'to-snake-case')
    setup_textcase_keymaps('-', 'to_dash_case', '- (dash-case)', 'to-dash-case')
    setup_textcase_keymaps('k', 'to_dash_case', 'kebab-case', 'to-kebab-case')
    setup_textcase_keymaps('d', 'to_dot_case', 'dot.case', 'to.dot.case')
    setup_textcase_keymaps('t', 'to_title_case', 'Title Case', 'To Title Case')
    setup_textcase_keymaps('/', 'to_path_case', 'path/case', 'to/path/case')
    setup_textcase_keymaps('<space>', 'to_phrase_case', 'phrase case', 'to phrase case')

end

return Plugin
