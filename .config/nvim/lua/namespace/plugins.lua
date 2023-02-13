-- AFTER EDITS TO THIS FILE
-- 1. Source this file with :so
-- 2. :PackerSync

-- USED PLUGINS
-- 'stefandtw/quickfix-reflector.vim' -- BAD!! make qf window modifiable,
-- 'zefei/vim-colortuner'
-- 'tmhedberg/SimpylFold' -- Python folds
-- 'terryma/vim-multiple-cursors'
-- 'tmhedberg/SimpylFold'

-- PLUGINS TO CHECKOUT
-- 'jose-elias-alvarez/null-ls.nvim' for autoformatting
-- 'mfussenegger/nvim-dap' auto inserting correct breakpoint type
-- 'adisen99/codeschool.nvim'

-- Boot strap packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup(
    function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Own plugin Rgflow
        use(vim.g.nvim_path .. "/tmp/nvim-rgflow.lua")

        -- Own plugin Capesky
        use(vim.g.nvim_path .. "/tmp/vim-capesky")
        -- use 'Abstract-IDE/Abstract-cs'

        -- OPERATOR + MOTION + TEXT-OBJECT = AWESOME
        use("wellle/targets.vim")
        use("tpope/vim-surround")
        use("numToStr/Comment.nvim")
        use("tpope/vim-repeat")
        use("vim-scripts/ReplaceWithRegister")
        use {
            -- xml attributes with x
            "whatyouhide/vim-textobj-xmlattr",
            requires = "kana/vim-textobj-user",
        }
        -- Require to set it before plug loads
        vim.g.titlecase_map_keys = 0
        use("christoomey/vim-titlecase")

        -- SMALL MISC
        use("tpope/vim-unimpaired")
        use("AndrewRadev/bufferize.vim")
        use("osyo-manga/vim-brightest")
        -- maybe messes up quickfix colors
        -- Allows one to easily align text
        use("junegunn/vim-easy-align")

        -- COLOR RELATED
        use("norcalli/nvim-colorizer.lua")
        use("pangloss/vim-javascript")

        -- SPELLCHECK EXTRAS
        use {
            "inkarkat/vim-SpellCheck",
            requires = "inkarkat/vim-ingo-library",
        }

        -- GIT
        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
        }
        use {
            "sindrets/diffview.nvim",
            requires = "nvim-lua/plenary.nvim",
        }

        -- FZF
        -- Install FZF on path by using ~/.config/install/utils.sh
        use {
            "ibhagwan/fzf-lua",
            -- optional for icon support
            requires = "nvim-tree/nvim-web-devicons"
        }

        -- TREE BROWSER
        use {
            -- optional, for file icons, better to load it before than as a requirement: https://github.com/nvim-tree/nvim-tree.lua/issues/1458
            "nvim-tree/nvim-web-devicons",
            "nvim-tree/nvim-tree.lua"
        }

        -- LSP
        -- Setup with Mason, from: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#you-might-not-need-lsp-zero
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig"
        }

        -- LSP Autocompletion Engine
        use {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", -- Optional
            "hrsh7th/cmp-path", -- Optional
            "saadparwaiz1/cmp_luasnip", -- Optional
            "hrsh7th/cmp-nvim-lua", -- Optional
            "L3MON4D3/LuaSnip" -- Snippets - Required
            -- 'rafamadriz/friendly-snippets', -- Snippets - Optional
        }

        -- TREESITTER
        -- They recommend updating the parsers on update
        use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require("packer").sync()
        end
    end
)
