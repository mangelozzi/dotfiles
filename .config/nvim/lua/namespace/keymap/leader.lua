local switcher = require("namespace.switcher")

-- If dont execute leader command, perform no operation instead of move one char to the right
-- Let whichkey grab this instead
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = "<Nop>" })

-- Disable highlighting
vim.keymap.set({"n", "x"}, "<leader>h", ":noh<CR>", {noremap = true, desc = "Disable highlighting"})

-- Replace with first spelling suggestion
vim.keymap.set("n", "<leader>c", "1z=", {noremap = true, desc = "(c)orrect spelling"})

-- Map ga to gA to text-case.nvim
vim.keymap.set("n", "<leader>a", "ga", {noremap = true, desc = "Show (A)scii value"})

-- Swap letters under cursor
vim.keymap.set("n", "<leader>x", "xp", {noremap = true, desc = "Swap chars"})

-- GIT ------------------------------------------------------------------------

-- Open the current file in GITk and dettach from the process
vim.keymap.set("n", "<leader>gk", function() vim.cmd('!gitk --follow -- % &') end, {noremap = true, desc ="Git(k) buffer"})

-- Open a Vsplit to left with the git diff of the current buffer
local function viewGitDiffCurrentFile()
    local filePath = vim.fn.expand('%')
    vim.cmd('vsplit | terminal git diff ' .. filePath)
end
vim.keymap.set('n', '<leader>gv', viewGitDiffCurrentFile, { noremap = true, silent = true, desc = "Git (v)split diff buffer" })

-- Diff two windows
vim.keymap.set("n", "<leader>gw", function() vim.cmd("windo diffthis") end, { noremap = true, desc = "Git diff (w)indows" })

-- SWAP -----------------------------------------------------------------------

-- Swap to single/double/back quotes with <leader>' or <leader>" or <leader>` respectively.
vim.keymap.set({"n", "x"}, [[<leader>']], [[:s/[`"]/'/g<CR>:noh<CR>]], {noremap = true, silent = true, desc = "Swap quotes to '"})
vim.keymap.set({"n", "x"}, [[<leader>"]], [[:s/['`]/"/g<CR>:noh<CR>]], {noremap = true, silent = true, desc = 'Swap quotes to "'})
vim.keymap.set({"n", "x"}, [[<leader>`]], [[:s/['"]/`/g<CR>:noh<CR>]], {noremap = true, silent = true, desc = "Swap quotes to `"})

-- Swap to underscore/dash with <leader>_ or <leader>-
vim.keymap.set({"n", "x"}, "<leader>_", ":s/-/_/g<CR>:noh<CR>", {noremap = true, desc = "Swap - to _"})
vim.keymap.set({"n", "x"}, "<leader>-", ":s/_/-/g<CR>:noh<CR>", {noremap = true, desc = "Swap _ to -"})

-- Swap numbers to given number, excl zeros
vim.keymap.set({"n", "x"}, "<leader>1", ":s/[1-9]/1/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 1"})
vim.keymap.set({"n", "x"}, "<leader>2", ":s/[1-9]/2/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 2"})
vim.keymap.set({"n", "x"}, "<leader>3", ":s/[1-9]/3/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 3"})
vim.keymap.set({"n", "x"}, "<leader>4", ":s/[1-9]/4/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 4"})
vim.keymap.set({"n", "x"}, "<leader>5", ":s/[1-9]/5/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 5"})
vim.keymap.set({"n", "x"}, "<leader>6", ":s/[1-9]/6/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 6"})
vim.keymap.set({"n", "x"}, "<leader>7", ":s/[1-9]/7/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 7"})
vim.keymap.set({"n", "x"}, "<leader>8", ":s/[1-9]/8/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 8"})
vim.keymap.set({"n", "x"}, "<leader>9", ":s/[1-9]/9/g<CR>:noh<CR>", {noremap = true, desc = "Swap numbers to 9"})

-- SWITCHER -------------------------------------------------------------------

-- Web Component Dev switching between files
vim.keymap.set("n", "<leader>cc", function() switcher.switch('component', 'css')        end, {noremap = true, desc = "Switch component css"})
vim.keymap.set("n", "<leader>cd", function() switcher.switch('component', 'def')        end, {noremap = true, desc = "Switch component def"})
vim.keymap.set("n", "<leader>ch", function() switcher.switch('component', 'html')       end, {noremap = true, desc = "Switch component html"})
vim.keymap.set("n", "<leader>cj", function() switcher.switch('component', 'javascript') end, {noremap = true, desc = "Switch component javascript"})
vim.keymap.set("n", "<leader>cm", function() switcher.switch('component', 'sample')     end, {noremap = true, desc = "Switch component sample"})
vim.keymap.set("n", "<leader>co", function() switcher.switch('component', 'other')      end, {noremap = true, desc = "Switch component other"})
vim.keymap.set("n", "<leader>cs", function() switcher.switch('component', 'story')      end, {noremap = true, desc = "Switch component story"})
vim.keymap.set("n", "<leader>ct", function() switcher.switch('component', 'type')       end, {noremap = true, desc = "Switch component type"})
vim.keymap.set("n", "<leader>cu", function() switcher.switch('component', 'utils')      end, {noremap = true, desc = "Switch component utils"})

-- Switching between Django app files
vim.keymap.set("n", "<leader>ad", function() switcher.switch('app', 'dint')             end, {noremap = true, desc = "Switch app dint"})
vim.keymap.set("n", "<leader>af", function() switcher.switch('app', 'fetcher')          end, {noremap = true, desc = "Switch app fetcher"})
vim.keymap.set("n", "<leader>am", function() switcher.switch('app', 'models')           end, {noremap = true, desc = "Switch app models"})
vim.keymap.set("n", "<leader>ao", function() switcher.switch('app', 'other')            end, {noremap = true, desc = "Switch app other"})
vim.keymap.set("n", "<leader>ar", function() switcher.switch('app', 'rest')             end, {noremap = true, desc = "Switch app rest"})
vim.keymap.set("n", "<leader>as", function() switcher.switch('app', 'serializers')      end, {noremap = true, desc = "Switch app serializers"})
vim.keymap.set("n", "<leader>at", function() switcher.switch('app', 'tests')            end, {noremap = true, desc = "Switch app tests"})
vim.keymap.set("n", "<leader>au", function() switcher.switch('app', 'urls')             end, {noremap = true, desc = "Switch app urls"})
vim.keymap.set("n", "<leader>av", function() switcher.switch('app', 'views')            end, {noremap = true, desc = "Switch app views"})
