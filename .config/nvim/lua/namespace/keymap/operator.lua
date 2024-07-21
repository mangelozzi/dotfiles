------- SORTING
-- Sort lines using Vim's built-in :sort command
function SortLines(startline, endline, unique)
    local cmd = unique and 'sort u' or 'sort'
    vim.cmd(startline .. ',' .. endline .. cmd)
end

-- Setup operator function for normal sorting
function NormalSortOperator()
    vim.go.operatorfunc = "v:lua.SortLines(vim.v.count1, vim.v.count2, false)"
    return 'g@'
end

-- Setup operator function for unique sorting
function UniqueSortOperator()
    vim.go.operatorfunc = "v:lua.SortLines(vim.v.count1, vim.v.count2, true)"
    return 'g@'
end

-- Normal mode mapping for normal and unique sort operators
vim.api.nvim_set_keymap('n', '<leader>s', [[:lua NormalSortOperator()<CR>]], { noremap = true, silent = true, desc = "(s) operator" })
vim.api.nvim_set_keymap('n', '<leader>S', [[:lua UniqueSortOperator()<CR>]], { noremap = true, silent = true, desc = "(S) unique operator" })

-- Visual mode mapping for direct sort without operator
vim.api.nvim_set_keymap('x', '<leader>s', [[:<C-u>lua SortLines(vim.fn.line("'<"), vim.fn.line("'>"), false)<CR>]], { noremap = true, silent = true, desc = "(s) operator" })
vim.api.nvim_set_keymap('x', '<leader>S', [[:<C-u>lua SortLines(vim.fn.line("'<"), vim.fn.line("'>"), true)<CR>]], { noremap = true, silent = true, desc = "(S) unique operator" })
