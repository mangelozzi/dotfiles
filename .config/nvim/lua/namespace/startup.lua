local StartupGroup = vim.api.nvim_create_augroup("StartupGroup", {clear = true})

vim.api.nvim_create_autocmd(
    "VimEnter" , {
        group = StartupGroup,
        callback = function (data)
            local is_actual_file = vim.fn.filereadable(data.file) == 1
            if not is_actual_file then

                -- Only if not a real file auto show tree
                -- require("nvim-tree.api").tree.toggle({focus = false })

                -- Show old files FZF picker
                -- require("fzf-lua").oldfiles()

            end
        end,
    }
)
