if not require("namespace.utils").get_is_installed("vim-capesky") then return end

-- Clears hi groups, so needs to be before other plugins
vim.cmd("color capesky")

vim.cmd('highlight Normal guifg=#e0e0e0 guibg=#606000')
vim.cmd('highlight EndOfBuffer guibg=#646400')
vim.cmd('highlight SignColumn guibg=#707070')
vim.cmd('highlight LineNr guifg=#a0a000 guibg=#686800')
vim.cmd('highlight Visual guibg=#404040')
