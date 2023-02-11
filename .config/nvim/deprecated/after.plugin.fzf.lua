-- https://www.youtube.com/watch?v=fP_ckZ30gbs&t=20m10s
-- To search within a dir `:FZF [dir] <CR>`

vim.g.FZF_DEFAULT_OPTS = "--bind ctrl-a:select-all"

-- By default uses .gitignore files, but sometimes whish to find files in
-- .gitignore
-- vim.g.FZF_DEFAULT_COMMAND = 'fdfind --type file --hidden'
-- -e = extension, e.g. fd -e 'svg' -e 'html'
-- -E = exclude extension, e.g. fd -E '*.py' -E '*.svg'
-- --hidden = Search hidden files (for dot config files)
-- Refer to: https://github.com/sharkdp/fd#excluding-specific-files-or-directories
-- htmlcov = python unittest coverage reports
vim.g.FZF_DEFAULT_COMMAND =
    "fdfind --type file --no-ignore" ..
    " -E '*__pycache__*' -E '*.jpg' -E '*.png' -E '*.zip' -E 'spike/*' -E '*.git' -E '*.min.css'" ..
    " -E '**/htmlcov/*' -E '**/static/*/wcapp/*.js'"

-- https://www.youtube.com/watch?v=fP_ckZ30gbs&t=21m42s
-- CTRL+P and CTRL+N previous/next file
-- TAB /SHIFT TAB to toggle marking
-- CTRL+A to select all matches
-- <ENTER> open all marked files in a quickfix window
vim.g.fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
