-- Recommend not setting a BG so it uses the current lines BG:
vim.api.nvim_set_hl(0, 'RgFlowQfPattern',    { fg="#a0ffa0", bold=true })
vim.api.nvim_set_hl(0, 'RgFlowHeadLine',     { fg="#00cc00", bg="#000000"}) -- divider line
-- Even though just a background, add the foreground or else when
-- appending cant see the insert cursor
vim.api.nvim_set_hl(0, 'RgFlowInputBg',      { fg="#000000", bg="#e0e0e0" })
vim.api.nvim_set_hl(0, 'RgFlowInputFlags',   { fg="#808080", bg="#e0e0e0", bold=true })
vim.api.nvim_set_hl(0, 'RgFlowInputPattern', { fg="#008000", bg="#e0e0e0", bold=true })  -- the pattern text
vim.api.nvim_set_hl(0, 'RgFlowInputPath',    { fg="#000000", bg="#e0e0e0" })

-vim.g.rgflow_flags = "--smart-case -g *.{*,py} -g !*{min.css,min.js,pyc,htmlz} -g !spike/* --fixed-strings --no-fixed-strings --no-ignore --ignore -M 500"

-- nnoremap <F9> :<C-U>lua rgflow.start_via_hotkey('n')<CR><ESC><CR>

-- Rip grep in files, use <cword> under the cursor as starting point
-- nnoremap <leader>rg :call myal#SearchInFiles('n')<Cr>
-- Rip grep in files, use visual selection as starting point
-- xnoremap <leader>rg :<C-U>call myal#SearchInFiles(visualmode())<Cr>
