local Plugin = {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
}

Plugin.config = function()
    require('git-conflict').setup{
        default_mappings = false, -- disable buffer local mapping created by this plugin
        -- default_commands = true, -- disable commands created by this plugin
        -- disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        -- list_opener = 'copen', -- command or function to open the conflicts list
        -- highlights = { -- They must have background color, otherwise the default color will be used
        --     incoming = 'DiffAdd',
        --     current = 'DiffText',
        -- }
    }

    vim.keymap.set('', '<leader>co', function() vim.cmd('GitConflictChooseOurs')   end, { silent = true, desc = "Select the current changes."})
    vim.keymap.set('', '<leader>ct', function() vim.cmd('GitConflictChooseTheirs') end, { silent = true, desc = "Select the incoming changes."})
    vim.keymap.set('', '<leader>cb', function() vim.cmd('GitConflictChooseBoth')   end, { silent = true, desc = "Select both changes."})
    vim.keymap.set('', '<leader>cx', function() vim.cmd('GitConflictChooseNone')   end, { silent = true, desc = "Select none of the changes."})
    vim.keymap.set('', ']x',         function() vim.cmd('GitConflictNextConflict') end, { silent = true, nowait = true, desc = "Move to the next conflict."})
    vim.keymap.set('', '[x',         function() vim.cmd('GitConflictPrevConflict') end, { silent = true, nowait = true, desc = "Move to the previous conflict."})
    vim.keymap.set('', '<leader>cw', function() vim.cmd('GitConflictListQf')       end, { silent = true, desc = "Get all conflict to quickfix"})
end

return Plugin
