-- vim
--
-- hi Normal guifg=#ffffff guibg=#333333
-- hi Comment guifg=#111111 gui=bold
-- hi Error guifg=#ff0000 gui=undercurl
-- hi Cursor gui=reverse
-- lua
--
-- :help nvim_set_hl
-- The first argument is the namespace, set to 0 for global
-- vim.api.nvim_set_hl(0, 'Normal', { fg = "#ffffff", bg = "#333333" })
-- vim.api.nvim_set_hl(0, 'Comment', { fg = "#111111", bold = true })
-- vim.api.nvim_set_hl(0, 'Error', { fg = "#ffffff", undercurl = true })
-- vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

-- LINKS

-- hi! link NeogitDiffAddHighlight   DiffAdd
-- vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { link = "DiffAdd"})


-- Used by autocmd to highlight text when yanked
vim.api.nvim_set_hl(0, 'HighlightOnYank', { fg = "#00ff00", bg="#008000"})
