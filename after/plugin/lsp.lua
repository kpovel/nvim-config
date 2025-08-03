vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, opts)
            vim.keymap.set({"i", "n"}, "<C-h>", vim.lsp.buf.signature_help, opts)
        end

    end,
})

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  virtual_text = true
})
