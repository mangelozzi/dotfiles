-- FUNCTION KEYS ---

-- <F1> Vim help on cword
vim.keymap.set({"", "!"}, "<F1>", "<ESC>:h <C-R><C-W><CR>", { noremap = true, desc = "Vim help on cword"})

-- <F2> Reload vim config
vim.keymap.set({"", "!"}, "<F2>", require("namespace.utils").reload_config, { noremap = true, desc = "Reload config"})

-- <F4> Close (safe if file buffers are modified)
local function safer_quit()
    local unsaved_file_buffers = {}
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local bufname = vim.api.nvim_buf_get_name(buf)
        -- print('file name2 is>>>'..bufname.."<<< type "..type(bufname).. ' is blank '.. tostring(bufname == "").. " length is ".. tostring(#bufname) .. ' ascii is '..string_to_ascii_list(bufname))
        local is_file = bufname ~= ""
        local is_modified = vim.api.nvim_get_option_value("modified", {buf = buf})
        local is_listed = vim.fn.buflisted(buf) ~= 0
        if is_modified and is_file and is_listed then
            table.insert(unsaved_file_buffers, buf)
        else
            if buf ~= current then
                -- We keep the current buffer open to maintain the jump list, so when reopen neovim CTRL+O gets as back to where we were
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    if #unsaved_file_buffers == 0 then
        vim.cmd("qa!")
    else
        if not vim.api.nvim_get_option_value("modified", {buf = current}) then
            -- Close the current buffer so we can focus on only unmodified buffers
            vim.api.nvim_buf_delete(current, { force = true })
        end
        -- Print a message indicating unsaved changes
        print("Unsaved changes in buffers with paths.")
    end
end
vim.keymap.set({"", "!"}, "<F4>", safer_quit, { noremap = true, desc = "Safer quit"})

-- <F4> Force quit (not save any changes)
vim.keymap.set({"", "!"}, "<M-F4>", function() vim.cmd('qa!') end, { noremap = true, desc = "Force quit"})
-- <F52> == <M-F4> in xterm-256color
vim.keymap.set({"", "!"}, "<F52>", function() vim.cmd('qa!') end, { noremap = true, desc = "Force quit"})
vim.keymap.set({"", "!"}, "<F16>", function() vim.cmd('qa!') end, { noremap = true, desc = "Shift+F4 = Force quit"})

-- OS xdg-open the current file
vim.keymap.set({"", "!"}, "<F5>", require("namespace.utils").run, {noremap = true, desc = "XDG-Open file"})

-- Autoformat the file
vim.keymap.set({"", "!"}, "<F6>", require("namespace.utils").format_code, {noremap = true, desc = "Autoformat the file"})

-- Copy the current filepath into the system clipboard
vim.keymap.set({"", "!"}, "<F7>", [[<ESC>:let @+=expand('%:p')<CR>:echo 'F7 - Copied ABSOLUTE file path'<CR>]], { noremap = true, desc = "Copy ABSOLUTE file path"})

-- Copy the current filepath into the system clipboard
vim.keymap.set({"", "!"}, "<F8>", "<ESC>:let@+=@%<CR>:echo 'F8 - Copied RELATIVE file path'<CR>", { noremap = true, desc = "Copy RELATIVE file path"})
