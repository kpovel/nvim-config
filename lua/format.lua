local function endsWith(str, suffix)
  return str:match(suffix .. "$") ~= nil
end

vim.keymap.set("n", "<leader>f", function()
  local filename = vim.api.nvim_buf_get_name(0)
  local js = endsWith(filename, "js") or endsWith(filename, "ts") or endsWith(filename, "tsx") or endsWith(filename, "jsx")

  if js then
    vim.cmd.write()
    local result = vim.system({ "npx", "--no-install", "prettier", "--write", filename }, { text = true }):wait()
    vim.cmd.checktime()
    if result.code ~= 0 then
      vim.notify(result.stderr ~= "" and result.stderr or result.stdout, vim.log.levels.ERROR)
    end
  else
    vim.lsp.buf.format()
  end
end)
