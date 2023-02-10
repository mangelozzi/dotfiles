vim.g.rgflow_flags = "--smart-case -g *.{*,py} -g !*{min.css,min.js,pyc,htmlz} -g !spike/* --fixed-strings --no-fixed-strings --no-ignore --ignore -M 500"

-- nnoremap <F9> :<C-U>lua rgflow.start_via_hotkey('n')<CR><ESC><CR>

-- Rip grep in files, use <cword> under the cursor as starting point
-- nnoremap <leader>rg :call myal#SearchInFiles('n')<Cr>
-- Rip grep in files, use visual selection as starting point
-- xnoremap <leader>rg :<C-U>call myal#SearchInFiles(visualmode())<Cr>
