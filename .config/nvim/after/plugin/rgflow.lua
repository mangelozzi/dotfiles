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
