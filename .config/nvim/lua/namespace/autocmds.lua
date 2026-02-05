-- :help api-autocmd

local utils = require("namespace.utils")

local NamespaceGroup = vim.api.nvim_create_augroup("NamespaceGroup", {clear = true})

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Source the lua/vim file after saving.",
        group = NamespaceGroup,
        -- pattern = {"*.lua", "*.vim"},
        pattern = {"*.vim"},
        callback = function()
            vim.cmd("messages clear")
            vim.cmd("source")
            print("File sourced after saving.")
            vim.fn.feedkeys("\\<CR>")
        end
    }
)

-- https://github.com/wbthomason/packer.nvim#quickstart
-- You can configure Neovim to automatically run :PackerCompile whenever plugins.lua is updated
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Run packer sync/compile after editing plugins.lua file",
        group = NamespaceGroup,
        pattern = "*/namespace/plugins.lua",
        callback = function()
            vim.cmd("PackerCompile")
            vim.cmd("PackerSync")
        end
    }
)

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "Highlight on yank",
        callback = function()
            vim.highlight.on_yank {timeout = 150, higroup = "HighlightOnYank"}
        end,
        group = NamespaceGroup,
        pattern = "*"
    }
)

-- Set global variable with current git branch
vim.api.nvim_create_autocmd(
    {"FileChangedShellPost", "BufEnter"},
    {
        desc = "Set the git branch for the status line",
        group = NamespaceGroup,
        callback = function()
            -- Update its buffer local variable every time swtiched too
            vim.b.current_git_branch = utils.get_git_branch()
        end
    }
)


vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        desc = "Remove trailing whitespace on save",
        pattern = {"*"},
        group = NamespaceGroup,
        callback = function()
            local excluded_filetypes = { "markdown", "html", "htmldjango" }
            local current_filetype = vim.bo.filetype
            for _, ft in ipairs(excluded_filetypes) do
                if current_filetype == ft then
                    return
                end
            end
            local save_cursor = vim.fn.getpos(".")
            pcall( -- catch any errors
                function()
                    vim.cmd [[%s/\s\+$//e]]
                end
            )
            vim.fn.setpos(".", save_cursor)
        end
    }
)

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Use most common line ending \\r\\n or just \\n",
    pattern = {"*"},
    group = NamespaceGroup,
    callback = function()
        -- Determine if we should remove stray "\r"
        -- If the file is already using dos line endings, we keep them.
        if vim.bo.fileformat == "dos" then return end
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local total_lines = #lines
        if total_lines == 0 then return end

        local cr_count = 0
        for _, line in ipairs(lines) do
            -- Check if the last character is a carriage return.
            if string.sub(line, -1) == "\r" then
            cr_count = cr_count + 1
            end
        end

        local save_cursor = vim.fn.getpos(".")
        local force_linux_end = true
        if force_linux_end or cr_count < (total_lines / 2) then
            -- If fewer than half of the lines end with "\r",
            -- then remove all stray "\r" characters.
            pcall(function()
                vim.cmd [[%s/\r//g]]
            end)
        else
            -- force all \r\n
            vim.cmd [[%s/$/\r/g]]
        end
        vim.fn.setpos(".", save_cursor)
    end
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Prettify Gateway Files",
        group = NamespaceGroup,
        pattern = {"*.js", "*.ts", "*.css", "*.less", "*.scss", "*.html", "*.json"},
        callback = function()
            local file = vim.fn.expand("%:p")
            if string.find(string.lower(file), "gateway") then
                vim.cmd("!prettier --write " .. file)
                vim.api.nvim_feedkeys("\\<CR>", "n", false)
                print("Prettied dat Gateway file")
            end
        end
    }
)


-- Copy the other editable window's relative file path into reg '8' and its alt bug into reg '9'
vim.api.nvim_create_autocmd(
    { "WinEnter" },
    {
        desc = "Copy other editable window's relative file path to register s",
        group = NamespaceGroup,
        callback = function()
            local cur_win = vim.api.nvim_get_current_win()
            local wins = vim.api.nvim_tabpage_list_wins(0)

            local other_win = nil
            for _, w in ipairs(wins) do
                if w ~= cur_win and utils.is_edit_win(w) then
                    other_win = w
                    break
                end
            end

            if not other_win then
                return
            end

            -- Helper: absolute -> relative-to-cwd (or nil if empty)
            local function rel(abs_path)
                if not abs_path or abs_path == "" then
                    return nil
                end
                return vim.fn.fnamemodify(abs_path, ":.")
            end

            -- 1) Other window's current buffer path -> register '8'
            local other_buf = vim.api.nvim_win_get_buf(other_win)
            local other_abs = vim.api.nvim_buf_get_name(other_buf)
            local other_rel = rel(other_abs)
            if other_rel then
                vim.fn.setreg("8", other_rel)
            end

            -- 2) Other window's alternate buffer path -> register '9'
            -- Must evaluate '#' in the context of the OTHER window.
            local alt_abs = vim.api.nvim_win_call(other_win, function()
                local alt_buf = vim.fn.bufnr("#")
                if alt_buf == -1 then
                    return ""
                end
                return vim.api.nvim_buf_get_name(alt_buf)
            end)
            local alt_rel = rel(alt_abs)
            if alt_rel then
                vim.fn.setreg("9", alt_rel)
            end
        end
    }
)
