local Plugin = {
    "akinsho/git-conflict.nvim",
    version = "*",
}

Plugin.config = function()
    require('git-conflict').setup{
        default_mappings = false, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        -- disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        -- list_opener = 'copen', -- command or function to open the conflicts list
        -- highlights = { -- They must have background color, otherwise the default color will be used
        --     incoming = 'DiffAdd',
        --     current = 'DiffText',
        -- }
    }
    -- <leader>c ... is used by the component switcher
    vim.keymap.set('', '<leader>er', function()
        vim.cmd('GitConflictRefresh')
        vim.cmd('redraw')
    end, { silent = true, desc = "(R)efresh (ie. attach)"})
    vim.keymap.set('', '<leader>eo', function() vim.cmd('GitConflictChooseOurs')   end, { silent = true, desc = "(O)urs - Select the current changes."})
    vim.keymap.set('', '<leader>et', function() vim.cmd('GitConflictChooseTheirs') end, { silent = true, desc = "(T)heirs - Select the incoming changes."})
    vim.keymap.set('', '<leader>eb', function() vim.cmd('GitConflictChooseBoth')   end, { silent = true, desc = "(B)oth - Select both changes."})
    vim.keymap.set('', '<leader>ex', function() vim.cmd('GitConflictChooseNone')   end, { silent = true, desc = "Select none of the changes."})
    vim.keymap.set('', ']c',         function() vim.cmd('GitConflictNextConflict') end, { silent = true, nowait = true, desc = "Git - Next conflict."})
    vim.keymap.set('', '[c',         function() vim.cmd('GitConflictPrevConflict') end, { silent = true, nowait = true, desc = "Git - Previous conflict."})
    vim.keymap.set('', '<leader>ew', function() vim.cmd('GitConflictListQf')       end, { silent = true, desc = "Get all conflict to quickfix"})
end

return Plugin
