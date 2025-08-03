vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")


require('lspconfig').elixirls.setup({
      cmd = { vim.fn.expand("~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh") }
})

require("mason-lspconfig").setup({ })

vim.lsp.enable({
"elixir-ls",
"html-lsp",
"tailwindcss-language-server",
"typescript-language-server",
})
