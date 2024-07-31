local M = {}

function M.detach_lsp(buf_nr)
   -- Stop LSP for the buffer to avoid semantic token errors
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        vim.lsp.buf_detach_client(buf_nr, client.id)
    end
end

return M
