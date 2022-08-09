hi NeogitNotificationInfo guifg=#80ff80
hi NeogitNotificationWarning guifg=#ffff00
hi NeogitNotificationError guifg=#ff00ff

" hi! link NeogitDiffAddHighlight   DiffAdd
" hi! link NeogitDiffDeleteHighlight DiffChange
hi NeogitDiffAddHighlight       guifg=#80ff80 guibg=#404040
hi NeogitDiffDeleteHighlight    guifg=#ff0000 guibg=#404040
hi NeogitDiffContextHighlight   guifg=#ffffff guibg=#404040

hi NeogitHunkHeader             guifg=#202020 guibg=#b0b0b0
hi NeogitHunkHeaderHighlight    guifg=#202020 guibg=#ffffff

nmap <leader>ga :!git add %<CR>
