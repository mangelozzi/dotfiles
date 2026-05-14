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
:lua print(vim.inspect(vim.lsp.get_clients()))

--]]

vim.pack.add({
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        name = "nvim-lspconfig",
    },
    {
        src = "https://github.com/hrsh7th/nvim-cmp",
        name = "nvim-cmp",
    },
    {
        src = "https://github.com/hrsh7th/cmp-nvim-lsp",
        name = "cmp-nvim-lsp",
    },
    {
        src = "https://github.com/williamboman/mason.nvim",
        name = "mason.nvim",
    },
    {
        src = "https://github.com/williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig.nvim",
    },
    {
        src = "https://github.com/nvimtools/none-ls.nvim",
        name = "none-ls.nvim",
    },
})

-- Map the LSP servers we want to install to whether default setup (true) or custom setup (false)
local my_servers = {
    ---- Manually setup
    html = false,
    lua_ls = false,
    pyright = false,
    ts_ls = false,
    ---- Auto Setup
    -- emmet_ls, -- emmet html completion support, prefer emmet-vim plugin
    bashls = true,
    cssls = true,
    css_variables = true,
    eslint = true, -- For JSDoc
    jsonls = true,
    marksman = true,
    zls = true, -- Zig
    angularls = true,
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

local function get_clients_supporting_method(bufnr, method)
    local clients = {}

    for _, client in ipairs(vim.lsp.get_clients({bufnr = bufnr})) do
        if client:supports_method(method, bufnr) then
            table.insert(clients, client.name)
        end
    end

    return clients
end

local function rename_symbol()
    local clients = get_clients_supporting_method(0, "textDocument/rename")

    if #clients == 0 then
        error("No attached LSP client supports textDocument/rename for this buffer")
    end

    vim.lsp.buf.rename()
end

local function open_diagnostic_float()
    vim.schedule(function()
        vim.diagnostic.open_float(nil, {
            scope = "line",
            focus = false,
            source = true,
            border = "rounded",
        })
    end)
end

local function jump_diagnostic(count)
    local diagnostic = vim.diagnostic.jump({count = count})

    if not diagnostic then
        return
    end

    open_diagnostic_float()
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = true,
        border = "rounded",
    },
})

-- 1. Setup Mason which will allow us to get LSP executables
-- Based on https://github.com/VonHeikemen/lsp-zero.nvim#you-might-not-need-lsp-zero
-- Mason installs LSP servers in a place neovim can see them, nothing more
require("mason").setup()

-- 2. Get LSP servers executables
-- :Mason ... select one and press i to install, add it to the `ensure_installed` below.
local ensure_installed = {}
for server, _ in pairs(my_servers) do
    if server ~= "curlylint" and server ~= "djlint" then
        table.insert(ensure_installed, server)
    end
end

require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    automatic_enable = false,
})

-- 3. Default LSP settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        if not client then
            error("LspAttach fired without a valid client")
        end

        local function get_opts(desc)
            return {buffer = bufnr, noremap = true, silent = true, desc = "LSP " .. desc}
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
        vim.keymap.set("n", "<leader>lwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, get_opts("List workspace folders"))
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, get_opts("(t)ype definition"))
        vim.keymap.set("n", "<leader>lr", rename_symbol, get_opts("(r)ename"))
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, get_opts("code (a)ction"))
        vim.keymap.set("n", "<leader>l?", open_diagnostic_float, get_opts("show diagnostic"))
        vim.keymap.set("n", "<leader>l.", open_diagnostic_float, get_opts("show diagnostic"))
        -- vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, get_opts("previous diagnostic"))
        -- vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, get_opts("next diagnostic"))
        vim.keymap.set("n", "[d", function()
            jump_diagnostic(-1)
        end, get_opts("previous diagnostic"))
        vim.keymap.set("n", "]d", function()
            jump_diagnostic(1)
        end, get_opts("next diagnostic"))
        -- vim.keymap.set('n', '<space>???', function() vim.diagnostic.set_loclist() end, get_opts('Set loclist'))
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({bufnr = bufnr})
        end, get_opts("(f)ormatting"))
        vim.keymap.set("n", "<leader>ll", function()
            vim.cmd("lsp restart")
            print("...LSP Restarted")
        end, get_opts("server restart"))
        vim.keymap.set("n", "<leader>li", function()
            vim.cmd("checkhealth vim.lsp")
        end, get_opts("server (i)nfo"))
        -- Note null-ls will always be shown as autostart: false in LspInfo, it is managed separately
        vim.keymap.set("n", "<leader>lI", function()
            vim.api.nvim_command("NullLsInfo")
        end, get_opts("server Null-ls (I)nfo"))
    end
})

-- 4. Setup LSP servers for the ones we wish to attach to buffers
-- :help lspconfig-quickstart recommends not using `require('mason-lspconfig').setup_handlers` but rather lspconfig
-- {filetypes}

-- First Default Setup
for server, default in pairs(my_servers) do
    if default then
        vim.lsp.enable(server)
    end
end

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {globals = {"vim"}}
        }
    },
    on_init = function(client)
        local workspace = client.workspace_folders and client.workspace_folders[1]
        local path = workspace and workspace.name
        local uv = vim.uv or vim.loop

        if not path then
            return
        end

        if uv.fs_stat(path .. "/.luarc.json") or uv.fs_stat(path .. "/.luarc.jsonc") then
            return
        end

        client.config.settings.Lua =
            vim.tbl_deep_extend(
            "force",
            client.config.settings.Lua or {},
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
})
vim.lsp.enable("lua_ls")

vim.lsp.config("ts_ls", {})
vim.lsp.enable("ts_ls")

vim.lsp.config("pyright", {
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
})
vim.lsp.enable("pyright")

vim.lsp.config("html", {
    filetypes = {"html", "htmldjango"} -- Add htmldjango
})
vim.lsp.enable("html")

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
