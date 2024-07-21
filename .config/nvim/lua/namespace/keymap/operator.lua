-- Sort lines using Vim's built-in :sort command
local utils = require('namespace.utils')

function SortLines(unique)
    -- Linewise operator
    local cmd = unique and 'sort u' or 'sort'
    local start_line = vim.fn.getpos("'[")[2]
    local end_line = vim.fn.getpos("']")[2]
    vim.cmd(start_line .. "," .. end_line .. cmd)
end

-- Setup operator function for normal sorting
function NormalSortOperator()
    utils.set_opfunc(function() SortLines(false) end)
    return 'g@'
end

-- Setup operator function for unique sorting
function UniqueSortOperator()
    utils.set_opfunc(function() SortLines(true) end)
    return 'g@'
end

-- Normal mode mapping for normal and unique sort operators
vim.keymap.set('n', '<leader>s', function() return NormalSortOperator() end, { noremap = true, silent = true, expr = true, desc = "(s) operator" })
vim.keymap.set('n', '<leader>S', function() return UniqueSortOperator() end, { noremap = true, silent = true, expr = true, desc = "(S) unique operator" })


-- Visual mode mapping for direct sort without operator
vim.keymap.set('x', '<leader>s', function()
    -- Basically just feed :sort
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':sort<cr>',true,false,true),'m',true)
    end,
    { noremap = true, silent = true, desc = "(s)ort operator" }
)
vim.keymap.set('x', '<leader>S', function()
    -- Basically just feed :sort u
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':sort u<cr>',true,false,true),'m',true)
    end,
    { noremap = true, silent = true, desc = "(S)ort unique operator" }
)
