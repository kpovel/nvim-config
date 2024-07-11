vim.keymap.set("n", "<C-L>", function()
  vim.fn.execute("!npx prettier --write " .. vim.fn.expand("%"))
end)
