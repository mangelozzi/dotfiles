setlocal iskeyword+=-,$,+

augroup i3_config_auto_commands
    autocmd!
    autocmd FileType i3config
        \ autocmd! BufWritePost * !i3 restart
augroup END
