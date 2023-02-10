-- osyo-manga/vim-brightest

-- Highlights the word the cusor currently is on.
vim.api.nvim_set_hl(0, '_VimBrightest', { bg = "#580058"})

vim.g["brightest#highlight"] = {
  group = "_VimBrightest"
}
