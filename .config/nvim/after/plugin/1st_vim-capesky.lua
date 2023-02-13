if not require("namespace.utils").get_is_installed("vim-capesky") then return end

-- Clears hi groups, so needs to be before other plugins
vim.cmd("color capesky")
