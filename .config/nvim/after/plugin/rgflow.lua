-- rg --vimgrep --smart-case -g '*.{*,py}' -g '!*.{min.js,pyc}' --fixed-strings --no-fixed-strings --no-ignore -M 500 -g '!**/static/*/jsapp/' -g '!**/static/*/wcapp/' function ~/linkcube/src

vim.cmd("highlight RgFlowInputPattern guifg=green gui=bold")

require("rgflow").setup(
    {
        default_trigger_mappings = true,
        default_ui_mappings = true,
        default_quickfix_mappings = true,
        -- WARNING !!! Glob for '-g *{*}' will not use .gitignore file: https://github.com/BurntSushi/ripgrep/issues/2252
        cmd_flags = ("--smart-case -g *.{*,py} -g !*.{min.css,min.js,pyc} --fixed-strings --no-fixed-strings --no-ignore -M 500"
            -- WARNING when testing changes, dont use "previous search", which will not include these changes, typing in the search term again
            -- Exclude globs
            .. " -g !**/.angular/"
            .. " -g !**/node_modules/"
            .. " -g !**/htmlcov/"
            .. " -g !**/static/*/jsapp/"
            .. " -g !**/static/*/wcapp/"
            .. " -g !**/coverage/"
            .. " -g !**/scraper/tests/templates/"
        )
    }
)

vim.keymap.set("n", "<leader>RG", function()
    require('rgflow').open(nil, nil, nil, {
        custom_start = function(pattern, flags, path)
            print('Pattern:'..pattern..' Flags:'..flags..' Path:'..path)
        end
    })
end, {noremap = true})

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
