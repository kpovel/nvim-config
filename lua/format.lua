function endsWith(str, suffix)
  return str:match(suffix .. "$") ~= nil
end

vim.keymap.set("n", "<leader>f", function()
  local filename = vim.fn.expand("%")
  local js = endsWith(filename, "js") or endsWith(filename, "ts") or endsWith(filename, "tsx") or endsWith(filename, "jsx") 

  if js then
    vim.fn.execute(":w")
    filename = filename:gsub("%[", "\\[")
    filename = filename:gsub("%]", "\\]")
    filename = filename:gsub("%(", "\\(")
    filename = filename:gsub("%)", "\\)")
    vim.fn.execute("!npx prettier --stdin-filepath --write " .. filename)
  else
    vim.lsp.buf.format()
  end
end)

