-- COMMAND MODE ---------------------------------------------------------------

-- Make it more bash like
-- If wish to implement more functionality (requiring functions), refer to:
-- https://github.com/houtsnip/vim-emacscommandline/blob/master/plugin/emacscommandline.vim

-- Delete word before cursor (natively supported)
-- <C-w>

-- Backspace (natively supported)
-- <C-h>


-- Goto line start / end
-- <C-e> -> natively supported goto line end
-- <C-a> -> NOT natively supported goto line start
vim.keymap.set("c", "<C-a>", "<HOME>", {noremap = true})

-- Move one character forwards/backwards
-- cnoremap <C-B>		<Left>
-- cnoremap <C-F>		<Right>  -- <C-f> is to bring up the command history

-- Delete character under cursor
vim.keymap.set("c", "<C-d>", "<DEL>", {noremap = true})

-- Recall Next/Previous command-line
-- Natively supported
-- <C-p>    <Up>
-- <C-n>    <Down>

-- Move back/forward one one word
vim.keymap.set("c", "<M-b>", "<S-Left>", {noremap = true})
vim.keymap.set("c", "<M-f>", "<S-Right>", {noremap = true})

-- Delete from cursor to line start/end
-- <C-u> (natively supported deleting to line start)
vim.keymap.set("c", "<C-k>", "<C-\\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>", {noremap = true})

-- Left/Right arrow backspace and delete
vim.keymap.set("c", "<C-l>", "<DEL>", {noremap = true})

-- In command mode, if there are no more characters to the right of the cursor
-- when delete is pressed, it starts to behave like backspace. Disable this.
vim.keymap.set("c", "<DEL>", require("namespace.utils").delete_to_right_only, { expr = true})


-- Variant of :Inspect, but runs on surrounding lines so the cursor does not alter the hl group
vim.api.nvim_create_user_command("InspectAround", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor[1]
    local col = cursor[2]
    local line_count = vim.api.nvim_buf_line_count(0)
    local function format_group(hl_group, priority)
        if priority ~= nil then
            return hl_group .. " (priority " .. priority .. ")"
        end
        return hl_group .. " (priority none)"
    end
    local function get_hl_groups(line)
        if line < 1 or line > line_count then
            return "out of range"
        end
        local inspected = vim.inspect_pos(0, line - 1, col, {
            extmarks = true,
            syntax = true,
            treesitter = true,
            semantic_tokens = true,
        })
        local groups = {}
        for _, extmark in ipairs(inspected.extmarks or {}) do
            local hl_group = extmark.opts and extmark.opts.hl_group
            local priority = extmark.opts and extmark.opts.priority
            if hl_group then
                table.insert(groups, format_group(hl_group, priority))
            end
        end
        for _, source in ipairs({ inspected.syntax, inspected.treesitter, inspected.semantic_tokens }) do
            for _, item in ipairs(source or {}) do
                if item.hl_group then
                    table.insert(groups, format_group(item.hl_group, item.priority))
                end
            end
        end
        return #groups > 0 and table.concat(groups, ", ") or "none"
    end
    print("For column: " .. col)
    print("Prev line: " .. get_hl_groups(current_line - 1))
    print("Current line: " .. get_hl_groups(current_line))
    print("Next line: " .. get_hl_groups(current_line + 1))
end, {})
