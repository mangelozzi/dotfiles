-- Although disabled in main init, something turns it on for lua files

-- Disable auto wrap lines, auto insert comment leader, other stupid magic
vim.opt.formatoptions:remove { "f", "c", "r", "o" }
