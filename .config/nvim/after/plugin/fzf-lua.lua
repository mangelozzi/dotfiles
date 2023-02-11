require("fzf-lua").setup {
    winopts = {
        ["--layout"] = "reverse-list"
    }
}

-- Buffers
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers, {noremap = true, silent = true})

-- Files
vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true})

-- Lines
vim.keymap.set("n", "<leader>f", require("fzf-lua").lines, {noremap = true, silent = true})

-- History
vim.keymap.set("n", "<leader>h", require("fzf-lua").oldfiles, {noremap = true, silent = true})
