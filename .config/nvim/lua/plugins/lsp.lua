--[[

- List of Lsp Setup options:
    - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

- List of LSP configurations:
    :help mason-lspconfig-server-map

- https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
- Native LSP with no plugins:
    - https://github.com/boltlessengineer/NativeVim/blob/main/lua/core/lsp.lua

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
        "nvimtools/none-ls.nvim"
    }
}

-- Map the LSP servers we want to install to whether default setup (true) or custom setup (false)
local my_servers = {
    ---- Manually setup
    html = false,
    lua_ls = false,
    pyright = false,
    tsserver = false,
    ---- Auto Setup
    -- emmet_ls, -- emmet html completion support, prefer emmet-vim plugin
    bashls = true,
    cssls = true,
    css_variables = true,
    eslint = true, -- For JSDoc
    jsonls = true,
    marksman = true,
    -- angularls = true,
    ---- Null Ls
    curlylint = false, -- Handled by none_ls -- Django
    djlint = false -- Handled by none_ls -- Django
}

local MIN_CHAR_LENGTH = 6
local custom_spell_generator = function(params, done)
    local original_fn = require("null-ls").builtins.completion.spell.generator.fn
    -- Call the original generator function with params and a callback
    original_fn(
        params,
        function(original_results)
            local results = {}
            for _, result_set in ipairs(original_results) do
                local filtered_items = {}
                for _, item in ipairs(result_set.items) do
                    if #item.label > MIN_CHAR_LENGTH then
                        table.insert(filtered_items, item)
                    end
                end
                table.insert(
                    results,
                    {
                        items = filtered_items,
                        isIncomplete = result_set.isIncomplete -- Preserve the isIncomplete field
                    }
                )
            end
            done(results)
        end
    )
end

Plugin.config = function()
    -- 1. Setup Mason which will allow us to get LSP executables
    -- Based on https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
    -- Mason installs LSP servers in a place neovim can see them, nothing more
    require("mason").setup()

    -- 2. Get LSP servers executables
    -- :Mason ... select one and press i to install, add it to the `ensure_installed` below.
    require("mason-lspconfig").setup {ensure_installed = my_servers}

    -- 3. Default LSP settings
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lsp_attach = function(client, bufnr)
        local function get_opts(desc)
            -- some key presses like gr wait for another press, so set nowait = true
            return {buffer = bufnr, noremap = true, nowait = true, desc = "LSP " .. desc}
        end

        -- Declaration - Wher you first declare a symbol (variable, constant, function etc.), e.g. let foo;
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration, get_opts("(d)eclaration"))
        -- Definition - Variable first assigned, of the signature of a func first defined, e.g. foo = 1;
        vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, get_opts("definition"))
        -- Implementation - The concrete implementation of a function
        vim.keymap.set("n", "gD", vim.lsp.buf.implementation, get_opts("implementation"))
        --
        -- references to a symbol (var/func) etc
        vim.keymap.set("n", "gr", vim.lsp.buf.references, get_opts("references"))
        --
        vim.keymap.set("n", "K", vim.lsp.buf.hover, get_opts("hover"))
        vim.keymap.set("i", "<C-F1>", vim.lsp.buf.signature_help, get_opts("help")) -- <c-H> is backspace in insert mode
        --
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, get_opts("(s)ignature help"))
        vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, get_opts("Workspace symbol"))
        vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, get_opts("Add workspace folder"))
        vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, get_opts("Remove workspace folder"))
        vim.keymap.set("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, get_opts("List workspace folders"))
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, get_opts("(t)ype definition"))
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, get_opts("(r)ename"))
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, get_opts("code (a)ction"))
        vim.keymap.set("n", "<leader>l?", vim.diagnostic.open_float, get_opts("show diagnostic"))
        vim.keymap.set("n", "<leader>l.", vim.diagnostic.open_float, get_opts("show diagnostic"))
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, get_opts("previous diagnostic"))
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, get_opts("next diagnostic"))
        -- vim.keymap.set('n', '<space>???', function() vim.diagnostic.set_loclist() end, get_opts('Set loclist'))
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.formatting() end, get_opts("(f)ormatting")) -- Sometimes is nil so wrap in a function
        vim.keymap.set("n", "<leader>ll", function() vim.api.nvim_command("LspRestart") print("...LSP Restarted") end, get_opts("server restart"))
        vim.keymap.set("n", "<leader>li", function() vim.api.nvim_command("LspInfo") end, get_opts("server (i)nfo"))
        -- Note null-ls will always be shown as autostart: false in LspInfo, it is managed separately
        vim.keymap.set("n", "<leader>lI", function() vim.api.nvim_command("NullLsInfo") end, get_opts("server Null-ls (I)nfo"))
        vim.keymap.set("n", "<leader>ln", function() require("namespace/lsputils").detach_lsp(0) end, get_opts("(n)o buf clients (detach)"))
    end

    -- 4. Setup LSP servers for the ones we wish to attach to buffers
    -- :help lspconfig-quickstart recommends not using `require('mason-lspconfig').setup_handlers` but rather lspconfig
    -- {filetypes}

    -- First Default Setup
    for server, default in pairs(my_servers) do
        if default then
            require("lspconfig")[server].setup {
                on_attach = lsp_attach,
                capabilities = capabilities
            }
        end
    end

    require("lspconfig").lua_ls.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {globals = {"vim"}}
            }
        },
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                return
            end
            client.config.settings.Lua =
                vim.tbl_deep_extend(
                "force",
                client.config.settings.Lua,
                {
                    runtime = {
                        version = "LuaJIT"
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                }
            )
        end
    }

    require("lspconfig").tsserver.setup {
        on_attach = lsp_attach,
        capabilities = capabilities
    }

    require("lspconfig").pyright.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 300
        },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                    maxNumberOfProblems = 20 -- was 50 - Try make pyright not so CPU hungry
                }
            }
        }
    }

    require("lspconfig").html.setup {
        on_attach = lsp_attach,
        capabilities = capabilities,
        filetypes = {"html", "htmldjango"} -- Add htmldjango
    }

    -- null-ls / none-ls
    local null_ls = require("null-ls") -- 'none-ls' keeps the original api name of 'null-ls'

    null_ls.setup {
        -- on_attach = lsp_attach,
        sources = {
            -- null_ls.builtins.formatting.stylua,
            -- djlint
            null_ls.builtins.formatting.djlint.with(
                {
                    extra_args = {"--reformat"}
                }
            ),
            null_ls.builtins.diagnostics.djlint
            -- curlylint
            -- null_ls.builtins.diagnostics.curlylint,

            -- {
            --     -- Conditionally include spell completion on markdown and text files only, and only for words longer than 6 characters
            --     method = null_ls.methods.COMPLETION,
            --     filetypes = {"markdown", "txt"}, -- Only enable for markdown and txt files
            --     generator = {
            --         fn = custom_spell_generator,
            --         async = true
            --     }
            -- }
        }
    }
end

return Plugin
