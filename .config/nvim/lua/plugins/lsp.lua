-- https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--[[

:help lspconfig-quickstart

See the config for each LSP
:lua print(vim.inspect(vim.lsp.get_active_clients()))

--]]
local Plugin = {
    "neovim/nvim-lspconfig",
    -- cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'},
    -- event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
        "hrsh7th/nvim-cmp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
}

-- Map the LSP servers we want to install to whether default setup (true) or custom setup (false)
local my_servers = {
    -- Replace these with whatever servers you want to install
    bashls = true,
    cssls = true,
    html = false,
    -- emmet_ls, -- emmet html completion support, prefer emmet-vim plugin
    pyright = false,
    tsserver = false,
    -- Tried typescript-tools, with config below, but did not seem faster
    eslint = true,  -- For JSDoc
    lua_ls = false,
    jsonls = true,
    marksman = true,
    djlint = true, -- Django
    curlylint = true, -- Django
    -- omnisharp,  -- C Sharp
    -- angularls = true,
}

local ensure_installed = {} -- The keys of my_servers
for key, _ in pairs(my_servers) do
    table.insert(ensure_installed, key)
end

Plugin.config = function ()

    -- 1. Setup Mason which will allow us to get LSP executables
    -- Based on https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
    -- Mason installs LSP servers in a place neovim can see them, nothing more
    require('mason').setup()

    -- 2. Get LSP servers executables
    -- :Mason ... select one and press i to install, add it to the `ensure_installed` below.
    require('mason-lspconfig').setup { ensure_installed = my_servers }

    -- 3. Default LSP settings
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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


    -- 4. Setup LSP servers for the ones we wish to attach to buffers
    -- :help lspconfig-quickstart recommends not using `require('mason-lspconfig').setup_handlers` but rather lspconfig
    -- {filetypes}

    -- First Default Setup
    for server, default in pairs(my_servers) do
        if default then
            require('lspconfig')[server].setup {
                on_attach = lsp_attach,
                capabilities = capabilities,
            }
        end
    end

    require('lspconfig').lua_ls.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = { globals = {'vim'} }
            }
        },
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
        },
    }

    require('lspconfig').tsserver.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
    }

    require('lspconfig').pyright.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 300,
        },
        settings = {
            python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                maxNumberOfProblems = 20, -- was 50 - Try make pyright not so CPU hungry
            },
            }
        }
    }

    require('lspconfig').html.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        filetypes = {'html', 'htmldjango'}, -- Add htmldjango
    }

end

return Plugin
