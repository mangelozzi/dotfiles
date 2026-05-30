-- Require every plugin file once. Each file owns its vim.pack.add(...) and setup.
-- Remove problem plugins like this:
-- 1. Delete from local share:
--      rm -rf ~/.local/share/nvim/site/pack/core/opt/diffview.nvim
-- 2. Delete entry from /home/michael/.config/nvim/nvim-pack-lock.json

require("plugins._noconfig")
require("plugins.brightest")
require("plugins.colorizer")
-- require("plugins.copilot")
require("plugins.diffview")
require("plugins.emmet-vim")
require("plugins.eyeliner")
require("plugins.fzf-lua")
require("plugins.git-conflict")
require("plugins.indent-blankline")
require("plugins.leap")
require("plugins.neogit")
require("plugins.nvim-cmp")
require("plugins.nvim-surround")
require("plugins.nvim-toggler")
require("plugins.nvim-tree")
require("plugins.nvim-various-textobjs")
require("plugins.oil")
require("plugins.replacewithregister")
require("plugins.rgflow")
require("plugins.text-case")
require("plugins.vim-doge")
require("plugins.whichkey")

-- Order Dependant Plugins --

require("plugins.none-ls")  -- Before lsp
require("plugins.lsp")

require("plugins.treesitter")
require("plugins.nvim-treesitter-textobjects") -- After treesitter
