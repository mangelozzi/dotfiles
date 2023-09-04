-- rg --vimgrep --smart-case -g '*.{*,py}' -g '!*.{min.js,pyc}' --fixed-strings --no-fixed-strings --no-ignore -M 500 -g '!**/static/*/jsapp/' -g '!**/static/*/wcapp/' function ~/linkcube/src
require('rgflow').setup({
    cmd_flags = ("--smart-case -g *.{*,py} -g !*.{min.js,pyc} --fixed-strings --no-fixed-strings --no-ignore -M 500"
        -- distros/cfm/app/meetings/static/meetings/jsapp/fetcher.js
                    .. " -g !**/static/*/jsapp/"
                    .. " -g !**/static/*/wcapp/"
)});


-- My old colors
-- local default_colors = {
--     -- Recommend not setting a BG so it uses the current lines BG
--     RgFlowQfPattern     = "guifg=#A0FFA0 guibg=none gui=bold ctermfg=15 ctermbg=none cterm=bold",
--     RgFlowHead          = "guifg=white   guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold",
--     RgFlowHeadLine      = "guifg=#00CC00 guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold",
--     -- Even though just a background, add the foreground or else when
--     -- appending cant see the insert cursor
--     RgFlowInputBg       = "guifg=black   guibg=#e0e0e0 ctermfg=0 ctermbg=254",
--     RgFlowInputFlags    = "guifg=gray    guibg=#e0e0e0 ctermfg=8 ctermbg=254",
--     RgFlowInputPattern  = "guifg=green   guibg=#e0e0e0 gui=bold ctermfg=2 ctermbg=254 cterm=bold",
--     RgFlowInputPath     = "guifg=black   guibg=#e0e0e0 ctermfg=0 ctermbg=254",
-- },
