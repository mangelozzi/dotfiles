if not require("namespace.utils").get_is_installed("nvim-lspconfig") then return end

-- Based on https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        -- Replace these with whatever servers you want to install
        'bashls',
        'cssls',
        'html',
        'pyright',
        'tsserver',
        'lua_ls',
        'jsonls',
        'marksman',
        'omnisharp',  -- C Sharp
        --'rust_analyzer',
    }
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_attach = function(client, bufnr)
    -- Create your keybindings here...
    vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', '<c-]>', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end, opts)
    -- vim.keymap.set("i", "<C-h>",   function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>lwa', function() vim.lsp.buf.add_workspace_folder() end, opts)
    vim.keymap.set('n', '<leader>lwr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
    vim.keymap.set('n', '<leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set('n', '<space>???', function() vim.diagnostic.set_loclist() end, opts)
    vim.keymap.set("n", "<space><F6>", function() vim.lsp.buf.formatting() end, opts)
    vim.keymap.set("n", "<space>ll", function() vim.api.nvim_command('LspRestart') end, opts)
end

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            -- https://neovim.discourse.group/t/how-to-suppress-warning-undefined-global-vim/1882/5
            settings = {
                Lua = {
                    diagnostics = { globals = {'vim'} }
                }
            }
        })
    end,
})
