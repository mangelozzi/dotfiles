vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "vim-doge" then
            return
        end

        if ev.data.kind == "install" or ev.data.kind == "update" then
            vim.cmd("call doge#install()")
        end
    end
})

vim.pack.add({
    {
        src = "https://github.com/kkoomen/vim-doge",
        name = "vim-doge",
    },
})
