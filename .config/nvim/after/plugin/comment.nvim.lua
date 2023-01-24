require('Comment').setup()

-- NORMAL
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

-- VISUAL
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment

-- EXTRA
-- `gco` - Insert comment to the next line and enters INSERT mode
-- `gcO` - Insert comment to the previous line and enters INSERT mode
-- `gcA` - Insert comment to end of the current line and enters INSERT mode

local opts = { silent=true }
vim.api.nvim_set_keymap('n', '<leader>j', 'gc', opts)
vim.api.nvim_set_keymap('n', '<leader>jl', 'gcc', opts)
vim.api.nvim_set_keymap('v', '<leader>j', 'gc', opts)

-- " COMMENTARY (old TPOPE setup)
-- " https://github.com/tpope/vim-commentary
-- " https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m02
-- " gc = comment
-- " gcc = comment out a line
-- " gcgc = Uncomment above, else below line
-- nmap <leader>j <Plug>Commentary
-- nmap <leader>J <Plug>CommentaryLine
-- " Change a block of comments
-- " nmap <leader>J <Plug>ChangeCommentary
-- xmap <leader>j  <Plug>Commentary
