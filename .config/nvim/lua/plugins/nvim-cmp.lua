-- LSP Autocompletion Engine

local Plugin = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer", -- Optional
        "hrsh7th/cmp-path", -- Optional
        "saadparwaiz1/cmp_luasnip", -- Optional
        "hrsh7th/cmp-nvim-lua", -- Optional
        "L3MON4D3/LuaSnip", -- Snippets - Required
        -- 'rafamadriz/friendly-snippets', -- Snippets - Optional
    },
}

Plugin.config = function()
    local cmp = require('cmp')
    cmp.setup {
        preselect = cmp.PreselectMode.None,
        completion = {
            keyword_length = 2,  -- Min word length before showing result
            -- autocomplete = false,  -- Dont auto popup
        },

        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            -- Michael: This is the desired golden behaviour:
            -- Auto complete only pops up after 4 chars
            -- Auto complete options is never auto selected
            -- Use <C-p> or <C-n> to select an option, and it changes the word immediately, one does not have to confirm selection
            -- <CR> inserts a line break, after changing to an autocomplete recommendation, one often wishes to insert a new line
            -- To select the first auto complete suggestion can press <C-l>, but rather just use <C-n>
            -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<C-l>"] = function(fallback)
                if cmp.visible() then
                    return cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }(fallback)
                else
                    return fallback()
                end
            end,
            ["<C-n>"] = function(fallback)
                if cmp.visible() then
                    return cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }(fallback)
                else
                    return cmp.mapping.complete { reason = cmp.ContextReason.Auto }(fallback)
                end
            end,
            ["<C-p>"] = function(fallback)
                if cmp.visible() then
                    return cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }(fallback)
                else
                    return cmp.mapping.complete { reason = cmp.ContextReason.Auto }(fallback)
                end
            end,
        }),
        sources = cmp.config.sources{
            { name = 'nvim_lsp' },
            -- { name = 'luasnip' }, -- For luasnip users.
        },
        --- Fall backs
        {
            { name = 'buffer' },
        }
    }
end

return Plugin
