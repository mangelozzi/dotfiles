local utils = require("namespace.utils")

-- Example `:Fd foo` to search for all files that contain foo in them.
vim.api.nvim_create_user_command('Fd', function(cmd_args)
    utils.fd_files_populate_qf(cmd_args.fargs[1])
end, {nargs = 1})
