local Plugin = {
    "neovim/nvim-lspconfig",
    cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
        "hrsh7th/nvim-cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
}

Plugin.config = function ()

    -- Based on https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
    require('mason').setup()

    require('mason-lspconfig').setup({
        ensure_installed = {
            -- Replace these with whatever servers you want to install
            'bashls',
            'cssls',
            'html',
            -- 'emmet_ls', -- emmet html completion support, prefer emmet-vim plugin
            'pyright',
            'tsserver',
            -- Tried 'typescript-tools', with config below, but did not seem faster
            'eslint',  -- For JSDoc
            'lua_ls',
            'jsonls',
            'marksman',
            -- 'omnisharp',  -- C Sharp
            -- 'angularls',
            --'rust_analyzer',
        }
    })

    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lsp_attach = function(client, bufnr)
        local function get_opts(desc)
            return {buffer = bufnr, noremap = true, desc = "LSP " .. desc}
        end

        vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.declaration() end, get_opts('Declaration'))
        vim.keymap.set('n', '<c-]>', function() vim.lsp.buf.definition() end, get_opts('Definition'))
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, get_opts('Hover'))
        vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end, get_opts('Implementation'))
        -- vim.keymap.set("i", "<C-h>",   function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, get_opts('Signature help'))
        vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, get_opts('Workspace symbol'))
        vim.keymap.set('n', '<leader>lwa', function() vim.lsp.buf.add_workspace_folder() end, get_opts('Add workspace folder'))
        vim.keymap.set('n', '<leader>lwr', function() vim.lsp.buf.remove_workspace_folder() end, get_opts('Remove workspace folder'))
        vim.keymap.set('n', '<leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, get_opts('List workspace folders'))
        vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.type_definition() end, get_opts('Type definition'))
        vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, get_opts('Rename'))
        vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, get_opts('Code action'))
        vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, get_opts('References'))
        vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.open_float() end, get_opts('Show diagnostic'))
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, get_opts('Previous diagnostic'))
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, get_opts('Next diagnostic'))
        -- vim.keymap.set('n', '<space>???', function() vim.diagnostic.set_loclist() end, get_opts('Set loclist'))
        vim.keymap.set("n", "<leader><F6>", function() vim.lsp.buf.formatting() end, get_opts('Formatting'))
        vim.keymap.set("n", "<leader>ll", function() vim.api.nvim_command('LspRestart'); print('...LSP Restarted') end, get_opts('Restart'))
    end

    local lspconfig = require('lspconfig')
    require('mason-lspconfig').setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            -- https://neovim.discourse.group/t/how-to-suppress-warning-undefined-global-vim/1882/5
                            globals = {'vim'}
                        },
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        }
                    },
                }
            })
        end,
    })

    -- Try make pyright not so CPU hungry
    lspconfig.pyright.setup({
    on_attach = lsp_attach,
    flags = {
        debounce_text_changes = 300, -- was 300
    },
    settings = {
        python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "basic",
            maxNumberOfProblems = 20, -- was 50
        },
        }
    }
    })

    -- if require("namespace.utils").get_is_installed("typescript-tools") then
    --     require("typescript-tools").setup {
    --         on_attach = lsp_attach,
    --         capabilities = lsp_capabilities,
    --     }
    -- end
end

return Plugin
