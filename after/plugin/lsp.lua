vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, opts)
            vim.keymap.set({"i", "n"}, "<C-h>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        end
    end,
})

vim.opt.completeopt = "menu,menuone,popup,noinsert,fuzzy"

vim.diagnostic.config({
  virtual_text = true
})
